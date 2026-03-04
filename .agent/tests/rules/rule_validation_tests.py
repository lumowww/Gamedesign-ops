#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Agent Rules Validation Tests

Tests for validating agent rule markdown files.
"""

import os
import re
import pytest
from pathlib import Path

# Base paths
# PROJECT_ROOT = Path(__file__).resolve().parents[2]  # .agent/tests/ → РOOT
PROJECT_ROOT = Path(__file__).resolve().parents[3]  # .agent/tests/rules/ → ROOT
RULES_DIR = PROJECT_ROOT / ".agent" / "rules"


class TestAgentRules:
    """Tests for agent rule files validation."""
    
    @pytest.fixture
    def rule_files(self):
        """Get all rule markdown files."""
        return list(RULES_DIR.glob("*.md"))
    
    def test_all_rule_files_exist(self):
        """Expected rule files should exist."""
        expected_files = [
            "00_global.md",
            "01_PM.md",
            "02_GD.md",
            "03_DEV.md",
            "04_UIUX.md",
            "05_ART.md",
            "06_PRODUCER.md"
        ]
        
        for expected in expected_files:
            rule_file = RULES_DIR / expected
            assert rule_file.exists(), f"Expected rule file not found: {expected}"
    
    def test_rule_file_numbering_sequence(self, rule_files):
        """Rule files should follow sequential numbering."""
        numbers = []
        for rf in rule_files:
            match = re.match(r'^(\d+)_', rf.name)
            if match:
                numbers.append(int(match.group(1)))
        
        numbers.sort()
        # Check for gaps in sequence
        for i in range(len(numbers) - 1):
            assert numbers[i+1] - numbers[i] <= 10, \
                f"Large gap in rule numbering: {numbers[i]} to {numbers[i+1]}"
    
    def test_dev_rule_has_gdd_protocol(self):
        """DEV rule should have GDD integration protocol."""
        dev_rule = RULES_DIR / "03_DEV.md"
        if not dev_rule.exists():
            pytest.skip("03_DEV.md does not exist")
        
        content = dev_rule.read_text(encoding='utf-8')
        assert "GDD" in content or "gdd" in content.lower(), \
            "DEV rule should reference GDD"
    
    def test_pm_rule_has_task_management(self):
        """PM rule should have task management responsibilities."""
        pm_rule = RULES_DIR / "01_PM.md"
        if not pm_rule.exists():
            pytest.skip("01_PM.md does not exist")
        
        content = pm_rule.read_text(encoding='utf-8')
        assert any(kw in content.lower() for kw in ['task', 'задач', 'backlog']), \
            "PM rule should mention task management"
    
    def test_producer_rule_is_entry_point(self):
        """PRODUCER rule should be marked as entry point."""
        producer_rule = RULES_DIR / "06_PRODUCER.md"
        if not producer_rule.exists():
            pytest.skip("06_PRODUCER.md does not exist")
        
        content = producer_rule.read_text(encoding='utf-8')
        assert any(kw in content.lower() for kw in ['entry', 'точка входа', 'start']), \
            "PRODUCER rule should indicate entry point role"


class TestRuleContent:
    """Tests for rule file content quality."""
    
    @pytest.fixture
    def rule_files(self):
        """Get all rule markdown files."""
        return list(RULES_DIR.glob("*.md"))
    
    def test_rule_file_min_length(self, rule_files):
        """Rule files should have minimum content length."""
        for rf in rule_files:
            content = rf.read_text(encoding='utf-8')
            assert len(content) >= 500, f"{rf.name} seems too short (< 500 chars)"
    
    def test_rule_file_has_rbac_section(self, rule_files):
        """Rule files should have RBAC or permissions section."""
        for rf in rule_files:
            content = rf.read_text(encoding='utf-8')
            has_rbac = any(kw in content.lower() for kw in 
                          ['rbac', 'permission', 'доступ', 'разреш', 'owner', 'владелец'])
            assert has_rbac, f"{rf.name} should have RBAC/permissions section"
    
    def test_rule_file_no_todo_markers(self, rule_files):
        """Rule files should not have TODO markers (should be complete)."""
        for rf in rule_files:
            content = rf.read_text(encoding='utf-8')
            # Exclude Kanban-style "TODO →" patterns (task status workflow diagram)
            # Only flag standalone TODO comments like "TODO:" or line starting with "TODO "
            lines = content.splitlines()
            for line in lines:
                # Skip Kanban workflow diagrams (TODO →)
                if 'TODO →' in line:
                    continue
                # Flag actual TODO markers
                if line.strip().startswith('TODO:') or line.strip().startswith('TODO '):
                    assert False, f"{rf.name} contains TODO marker: {line.strip()}"


if __name__ == "__main__":
    pytest.main([__file__, "-v"])
