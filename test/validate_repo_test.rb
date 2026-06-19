require "fileutils"
require "minitest/autorun"
require "tmpdir"

require_relative "../scripts/validate_repo"

class ValidateRepoTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__)

  def test_current_repo_passes_validation
    result = RepoValidator.validate(ROOT)

    assert_equal [], result.errors
  end

  def test_missing_setup_skill_is_reported
    Dir.mktmpdir do |dir|
      write_minimal_repo(dir, setup_skill: "skills/missing.md")

      result = RepoValidator.validate(dir)

      assert_includes result.errors, "missing setup skill: skills/missing.md"
    end
  end

  def test_missing_gap_in_readme_is_reported
    Dir.mktmpdir do |dir|
      write_minimal_repo(dir, readme: "# Test\n\n## Known Gaps\n\n")

      result = RepoValidator.validate(dir)

      assert_includes result.errors, "README missing gap: Agent-safe account creation broker"
    end
  end

  def test_missing_eval_task_file_is_reported
    Dir.mktmpdir do |dir|
      write_minimal_repo(dir, include_eval_task: false)

      result = RepoValidator.validate(dir)

      assert_includes result.errors, "missing eval task: evals/simulated-agent/tasks/test-task.md"
    end
  end

  private

  def write_minimal_repo(dir, setup_skill: "skills/test.md", readme: nil, include_eval_task: true)
    FileUtils.mkdir_p(File.join(dir, "data"))
    FileUtils.mkdir_p(File.join(dir, "resources"))
    FileUtils.mkdir_p(File.join(dir, "skills"))
    FileUtils.mkdir_p(File.join(dir, "evals/simulated-agent/tasks"))

    File.write(File.join(dir, "README.md"), readme || <<~MD)
      # Test

      ## Known Gaps

      - Agent-safe account creation broker
    MD
    File.write(File.join(dir, "llms.txt"), "Read data/resources.yml first.\n")
    File.write(File.join(dir, "CONTRIBUTING.md"), "# Contributing\n")
    File.write(File.join(dir, "resources/email.md"), "# Email\n")
    File.write(File.join(dir, "skills/test.md"), "# Test skill\n") if setup_skill == "skills/test.md"
    File.write(File.join(dir, "evals/simulated-agent/tasks/test-task.md"), "# Test Task\n") if include_eval_task
    File.write(File.join(dir, "evals/simulated-agent/rubric.yml"), <<~YAML)
      version: 1
      tasks:
        - id: test-task
          file: evals/simulated-agent/tasks/test-task.md
    YAML
    File.write(File.join(dir, "data/resources.yml"), <<~YAML)
      last_researched: "2026-06-19"
      categories:
        - id: email
          name: Email
          resources:
            - name: TestMail
              url: https://example.com/
              docs: https://example.com/docs
              status: verified-primary-docs
              agent_asset: test inbox
              why: "Provides a test inbox."
              setup_skill: #{setup_skill}
              human_approval_needed:
                - production use
      gaps:
        - primitive: Agent-safe account creation broker
          status: missing
          note: "No verified general service."
    YAML
  end
end
