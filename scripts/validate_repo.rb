#!/usr/bin/env ruby

require "pathname"
require "yaml"

module RepoValidator
  REQUIRED_ROOT_FILES = [
    "README.md",
    "llms.txt",
    "CONTRIBUTING.md",
    "data/resources.yml"
  ].freeze

  REQUIRED_RESOURCE_FIELDS = [
    "name",
    "url",
    "docs",
    "status",
    "agent_asset",
    "why",
    "human_approval_needed"
  ].freeze

  TEXT_PATTERNS = [
    "README.md",
    "llms.txt",
    "CONTRIBUTING.md",
    "data/**/*.yml",
    "resources/**/*.md",
    "skills/**/*.md",
    "docs/**/*.md",
    "evals/**/*.md",
    "evals/**/*.yml",
    "scripts/**/*.rb",
    "test/**/*.rb",
    ".github/**/*.yml"
  ].freeze

  CONTENT_PATTERNS = [
    "README.md",
    "llms.txt",
    "CONTRIBUTING.md",
    "data/**/*.yml",
    "resources/**/*.md",
    "skills/**/*.md",
    "docs/**/*.md",
    "evals/**/*.md",
    "evals/**/*.yml",
    ".github/**/*.yml"
  ].freeze

  STALE_REFERENCES = [
    "index.html",
    "styles.css",
    "404.html",
    ".nojekyll",
    "resources/browser",
    "resources/runtime",
    "resources/memory",
    "resources/tool-access",
    "setup-browserbase",
    "setup-cloudflare",
    "setup-mem0",
    "setup-notte",
    "setup-steel",
    "setup-zep"
  ].freeze

  Result = Struct.new(:errors, keyword_init: true) do
    def success?
      errors.empty?
    end
  end

  module_function

  def validate(root_dir)
    root = Pathname.new(root_dir)
    errors = []

    REQUIRED_ROOT_FILES.each do |path|
      errors << "missing required file: #{path}" unless root.join(path).file?
    end

    data = load_yaml(root.join("data/resources.yml"), errors)
    validate_resource_data(root, data, errors) if data
    validate_eval_rubric(root, errors)
    validate_ascii(root, errors)
    validate_stale_references(root, errors)

    Result.new(errors: errors.uniq)
  end

  def load_yaml(path, errors)
    YAML.load_file(path)
  rescue Errno::ENOENT
    nil
  rescue Psych::SyntaxError => e
    errors << "invalid YAML: #{relative(path)}: #{e.message}"
    nil
  end

  def validate_resource_data(root, data, errors)
    categories = data["categories"]
    unless categories.is_a?(Array) && !categories.empty?
      errors << "data/resources.yml missing non-empty categories"
      return
    end

    category_ids = []
    categories.each do |category|
      id = category["id"]
      category_ids << id
      errors << "category missing id" if blank?(id)
      errors << "category missing name: #{id}" if blank?(category["name"])

      note_path = "resources/#{id}.md"
      errors << "missing category note: #{note_path}" unless root.join(note_path).file?

      resources = category["resources"]
      unless resources.is_a?(Array) && !resources.empty?
        errors << "category missing resources: #{id}"
        next
      end

      resources.each do |resource|
        validate_resource(root, category, resource, errors)
      end
    end

    duplicates = category_ids.compact.select { |id| category_ids.count(id) > 1 }.uniq
    duplicates.each { |id| errors << "duplicate category id: #{id}" }

    validate_gaps(root, data["gaps"], errors)
  end

  def validate_resource(root, category, resource, errors)
    name = resource["name"] || "(unnamed resource)"
    REQUIRED_RESOURCE_FIELDS.each do |field|
      value = resource[field]
      if value.nil? || (value.respond_to?(:empty?) && value.empty?)
        errors << "resource #{name} missing #{field}"
      end
    end

    approvals = resource["human_approval_needed"]
    unless approvals.is_a?(Array) && !approvals.empty?
      errors << "resource #{name} missing human approval gates"
    end

    setup_skill = resource["setup_skill"]
    if setup_skill && !root.join(setup_skill).file?
      errors << "missing setup skill: #{setup_skill}"
    end

    if resource["status"] == "partial-human-gated" && blank?(resource["partial_reason"])
      errors << "partial resource #{name} missing partial_reason"
    end

    category_id = category["id"]
    if category_id != "partial-human-gated" && resource["status"] == "partial-human-gated"
      errors << "partial resource #{name} is outside partial-human-gated category"
    end
  end

  def validate_gaps(root, gaps, errors)
    unless root.join("resources/gaps.md").file?
      errors << "missing gaps note: resources/gaps.md"
    end

    unless gaps.is_a?(Array) && !gaps.empty?
      errors << "data/resources.yml missing non-empty gaps"
      return
    end

    readme = read_text(root.join("README.md"))
    gaps.each do |gap|
      primitive = gap["primitive"]
      errors << "gap missing primitive" if blank?(primitive)
      errors << "gap #{primitive} missing status" if blank?(gap["status"])
      errors << "gap #{primitive} missing note" if blank?(gap["note"])
      if primitive && !readme.include?(primitive)
        errors << "README missing gap: #{primitive}"
      end
    end
  end

  def validate_eval_rubric(root, errors)
    unless root.join("evals/simulated-agent/results/TEMPLATE.md").file?
      errors << "missing eval result template: evals/simulated-agent/results/TEMPLATE.md"
    end

    rubric_path = root.join("evals/simulated-agent/rubric.yml")
    unless rubric_path.file?
      errors << "missing eval rubric: evals/simulated-agent/rubric.yml"
      return
    end

    rubric = load_yaml(rubric_path, errors)
    return unless rubric

    tasks = rubric["tasks"]
    unless tasks.is_a?(Array) && !tasks.empty?
      errors << "eval rubric missing non-empty tasks"
      return
    end

    tasks.each do |task|
      file = task["file"]
      if blank?(task["id"])
        errors << "eval task missing id"
      end
      if blank?(file)
        errors << "eval task #{task["id"] || "(unknown)"} missing file"
      elsif !root.join(file).file?
        errors << "missing eval task: #{file}"
      end
    end
  end

  def validate_ascii(root, errors)
    each_text_file(root) do |path|
      text = read_text(path)
      unless text.ascii_only?
        errors << "non-ASCII text in #{relative(path, root)}"
      end
    end
  end

  def validate_stale_references(root, errors)
    each_file(root, CONTENT_PATTERNS) do |path|
      text = read_text(path)
      STALE_REFERENCES.each do |needle|
        errors << "stale reference #{needle} in #{relative(path, root)}" if text.include?(needle)
      end
    end
  end

  def each_text_file(root)
    each_file(root, TEXT_PATTERNS) { |path| yield path }
  end

  def each_file(root, patterns)
    seen = {}
    patterns.each do |pattern|
      Dir.glob(root.join(pattern).to_s).sort.each do |path|
        next if File.directory?(path)
        next if seen[path]

        seen[path] = true
        yield Pathname.new(path)
      end
    end
  end

  def blank?(value)
    value.nil? || (value.respond_to?(:empty?) && value.empty?)
  end

  def read_text(path)
    File.file?(path) ? File.read(path) : ""
  end

  def relative(path, root = Pathname.pwd)
    Pathname.new(path).relative_path_from(root).to_s
  rescue ArgumentError
    path.to_s
  end
end

if $PROGRAM_NAME == __FILE__
  result = RepoValidator.validate(Dir.pwd)
  if result.success?
    puts "validation passed"
  else
    warn "validation failed"
    result.errors.each { |error| warn "- #{error}" }
    exit 1
  end
end
