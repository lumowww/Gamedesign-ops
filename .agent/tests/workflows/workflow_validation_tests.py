#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Agent Workflow Validation Tests

Tests for validating agent workflow markdown files.
Checks for required sections, proper syntax, and consistency.
"""

import os
import re
import pytest
from pathlib import Path

# Base paths
PROJECT_ROOT = Path(r"D:\ASTRA\My project")
WORKFLOWS_DIR = PROJECT_ROOT / ".agent" / "workflows"
RULES_DIR = PROJECT_ROOT / ".agent" / "rules"
BRAIN_DIR = PROJECT_ROOT / ".gemini" / "antigravity" / "brain"


class TestWorkflows:
    """Tests for workflow markdown files."""
    
    @pytest.fixture
    def workflow_files(self):
        """Get all workflow markdown files."""
        return list(WORKFLOWS_DIR.glob("*.md"))
    
    def test_workflow_files_exist(self, workflow_files):
        """At least one workflow file should exist."""
        assert len(workflow_files) > 0, "No workflow files found"
    
    def test_workflow_has_title(self, workflow_files):
        """Each workflow should have a title (H1 header)."""
        for wf in workflow_files:
            content = wf.read_text(encoding='utf-8')
            assert content.strip().startswith("#"), f"{wf.name} should start with H1 title"
    
    def test_workflow_has_description(self, workflow_files):
        """Each workflow should have a description section."""
        for wf in workflow_files:
            content = wf.read_text(encoding='utf-8')
            assert "##" in content, f"{wf.name} should have at least one H2 section"
    
    def test_workflow_has_commands(self, workflow_files):
        """Each workflow should document slash commands."""
        for wf in workflow_files:
            content = wf.read_text(encoding='utf-8')
            assert "/" in content, f"{wf.name} should document slash commands"
    
    def test_workflow_no_broken_links(self, workflow_files):
        """Check for obvious broken markdown links."""
        link_pattern = re.compile(r'\[([^\]]+)\]\(([^\)]+)\)')
        for wf in workflow_files:
            content = wf.read_text(encoding='utf-8')
            links = link_pattern.findall(content)
            for text, url in links:
                # Skip external URLs
                if url.startswith('http'):
                    continue
                # Internal links should exist
                if not url.startswith('#'):
                    target = PROJECT_ROOT / url.split('#')[0]
                    assert target.exists(), f"Broken link in {wf.name}: {url}"


class TestRules:
    """Tests for agent rule markdown files."""
    
    @pytest.fixture
    def rule_files(self):
        """Get all rule markdown files."""
        return list(RULES_DIR.glob("*.md"))
    
    def test_rule_files_exist(self, rule_files):
        """At least one rule file should exist."""
        assert len(rule_files) > 0, "No rule files found"
    
    def test_rule_numbering(self, rule_files):
        """Rule files should follow numbering convention (00_*.md, 01_*.md, etc.)."""
        for rf in rule_files:
            assert re.match(r'^\d+_', rf.name), f"{rf.name} should start with number prefix"
    
    def test_rule_has_role_definition(self, rule_files):
        """Each rule file should define a role."""
        for rf in rule_files:
            content = rf.read_text(encoding='utf-8')
            assert any(keyword in content.lower() for keyword in ['role', 'агент', 'роль']), \
                f"{rf.name} should define a role"
    
    def test_rule_has_responsibilities(self, rule_files):
        """Each rule file should list responsibilities."""
        for rf in rule_files:
            content = rf.read_text(encoding='utf-8')
            assert any(keyword in content.lower() for keyword in ['responsibility', 'обязанн', 'responsibilities']), \
                f"{rf.name} should list responsibilities"


class TestBrainFiles:
    """Tests for brain communication files."""
    
    @pytest.fixture
    def brain_files(self):
        """Get all brain markdown files."""
        if not BRAIN_DIR.exists():
            pytest.skip("Brain directory does not exist")
        return list(BRAIN_DIR.glob("*.md"))
    
    def test_brain_directory_exists(self):
        """Brain directory should exist."""
        assert BRAIN_DIR.exists(), "Brain directory not found"
    
    def test_brain_files_have_content(self, brain_files):
        """Brain files should not be empty."""
        for bf in brain_files:
            content = bf.read_text(encoding='utf-8')
            assert len(content.strip()) > 0, f"{bf.name} is empty"
    
    def test_project_context_has_required_sections(self):
        """project_context.md should have required sections."""
        context_file = BRAIN_DIR / "project_context.md"
        if not context_file.exists():
            pytest.skip("project_context.md does not exist")
        
        content = context_file.read_text(encoding='utf-8')
        required_sections = ['Проект', 'Команда', 'Статус']
        for section in required_sections:
            assert section in content, f"project_context.md missing section: {section}"


class TestMarkdownSyntax:
    """Tests for markdown syntax validation."""
    
    @pytest.fixture
    def all_markdown_files(self):
        """Get all markdown files in .agent directory."""
        agent_dir = PROJECT_ROOT / ".agent"
        if not agent_dir.exists():
            return []
        return list(agent_dir.rglob("*.md"))
    
    def test_no_tabs_in_markdown(self, all_markdown_files):
        """Markdown files should not contain tabs (use spaces)."""
        for mf in all_markdown_files:
            content = mf.read_text(encoding='utf-8')
            assert '\t' not in content, f"Tab found in {mf.name}"
    
    def test_no_trailing_whitespace(self, all_markdown_files):
        """Markdown files should not have trailing whitespace."""
        for mf in all_markdown_files:
            content = mf.read_text(encoding='utf-8')
            for i, line in enumerate(content.splitlines(), 1):
                assert not line.endswith(' '), f"Trailing space in {mf.name}:{i}"
                assert not line.endswith('\t'), f"Trailing tab in {mf.name}:{i}"


if __name__ == "__main__":
    pytest.main([__file__, "-v"])
