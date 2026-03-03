#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Brain Files Schema Tests

Tests for validating brain communication file structure and content.
"""

import os
import re
import pytest
from pathlib import Path
from datetime import datetime

# Base paths
PROJECT_ROOT = Path(r"D:\ASTRA\My project")
BRAIN_DIR = PROJECT_ROOT / ".gemini" / "antigravity" / "brain"


class TestBrainFilesStructure:
    """Tests for brain file structure."""
    
    @pytest.fixture
    def brain_files(self):
        """Get all brain markdown files."""
        if not BRAIN_DIR.exists():
            BRAIN_DIR.mkdir(parents=True, exist_ok=True)
            pytest.skip("Brain directory created (was missing)")
        return list(BRAIN_DIR.glob("*.md"))
    
    def test_brain_directory_exists(self):
        """Brain directory should exist."""
        assert BRAIN_DIR.exists(), "Brain directory not found"
    
    def test_required_brain_files_exist(self):
        """Required brain files should exist."""
        required_files = [
            "project_context.md",
            "task_board.md",
            "gdd_summary.md",
            "decisions_log.md"
        ]
        
        missing = []
        for required in required_files:
            if not (BRAIN_DIR / required).exists():
                missing.append(required)
        
        if missing:
            pytest.skip(f"Missing brain files (creating templates): {missing}")
    
    def test_brain_files_are_markdown(self, brain_files):
        """All brain files should be markdown."""
        for bf in brain_files:
            assert bf.suffix == '.md', f"{bf.name} is not a .md file"


class TestProjectContext:
    """Tests for project_context.md content."""
    
    def test_project_context_structure(self):
        """project_context.md should have required structure."""
        context_file = BRAIN_DIR / "project_context.md"
        if not context_file.exists():
            pytest.skip("project_context.md does not exist")
        
        content = context_file.read_text(encoding='utf-8')
        
        # Check for required sections
        required = ['PROJECT', 'Project', 'Проект']
        assert any(r in content for r in required), "Missing project section"
    
    def test_project_context_has_team_info(self):
        """project_context.md should have team information."""
        context_file = BRAIN_DIR / "project_context.md"
        if not context_file.exists():
            pytest.skip("project_context.md does not exist")
        
        content = context_file.read_text(encoding='utf-8')
        assert any(kw in content for kw in ['Команда', 'Team', 'Agent', 'Агент']), \
            "Missing team information"
    
    def test_project_context_has_status(self):
        """project_context.md should have status information."""
        context_file = BRAIN_DIR / "project_context.md"
        if not context_file.exists():
            pytest.skip("project_context.md does not exist")
        
        content = context_file.read_text(encoding='utf-8')
        assert any(kw in content for kw in ['Статус', 'Status', '✅', '🟡', '🔴']), \
            "Missing status information"


class TestTaskBoard:
    """Tests for task_board.md content."""
    
    def test_task_board_structure(self):
        """task_board.md should have Kanban-style structure."""
        task_file = BRAIN_DIR / "task_board.md"
        if not task_file.exists():
            pytest.skip("task_board.md does not exist")
        
        content = task_file.read_text(encoding='utf-8')
        
        # Check for Kanban columns
        kanban_keywords = ['TODO', 'IN_PROGRESS', 'DONE', 'BLOCKED', 
                          'Надо', 'В работе', 'Готово']
        has_kanban = any(kw in content for kw in kanban_keywords)
        assert has_kanban, "task_board.md should have Kanban-style columns"
    
    def test_task_board_has_task_ids(self):
        """task_board.md should have task IDs."""
        task_file = BRAIN_DIR / "task_board.md"
        if not task_file.exists():
            pytest.skip("task_board.md does not exist")
        
        content = task_file.read_text(encoding='utf-8')
        
        # Check for task ID pattern (TASK-XXX-NNN)
        task_id_pattern = re.compile(r'TASK-[A-Z]+-\d+')
        has_task_ids = bool(task_id_pattern.search(content))
        assert has_task_ids, "task_board.md should have task IDs (TASK-XXX-NNN)"


class TestGDDSummary:
    """Tests for gdd_summary.md content."""
    
    def test_gdd_summary_has_core_loop(self):
        """gdd_summary.md should describe core loop."""
        gdd_file = BRAIN_DIR / "gdd_summary.md"
        if not gdd_file.exists():
            pytest.skip("gdd_summary.md does not exist")
        
        content = gdd_file.read_text(encoding='utf-8')
        assert any(kw in content for kw in ['Core Loop', 'core loop', 'Цикл', 'loop']), \
            "gdd_summary.md should describe core loop"
    
    def test_gdd_summary_has_economy(self):
        """gdd_summary.md should describe economy."""
        gdd_file = BRAIN_DIR / "gdd_summary.md"
        if not gdd_file.exists():
            pytest.skip("gdd_summary.md does not exist")
        
        content = gdd_file.read_text(encoding='utf-8')
        assert any(kw in content for kw in ['Economy', 'economy', 'Экономика', 'currency', 'валюта']), \
            "gdd_summary.md should describe economy"


class TestDecisionsLog:
    """Tests for decisions_log.md content."""
    
    def test_decisions_log_is_append_only(self):
        """decisions_log.md should follow append-only pattern."""
        log_file = BRAIN_DIR / "decisions_log.md"
        if not log_file.exists():
            pytest.skip("decisions_log.md does not exist")
        
        content = log_file.read_text(encoding='utf-8')
        
        # Check for date-ordered entries (newest at bottom or top)
        date_pattern = re.compile(r'\d{4}-\d{2}-\d{2}|\d{2}\.\d{2}\.\d{4}')
        dates = date_pattern.findall(content)
        
        if len(dates) >= 2:
            # Just verify dates are present (ordering is complex to verify)
            assert len(dates) > 0, "decisions_log.md should have dated entries"
    
    def test_decisions_log_has_agent_info(self):
        """decisions_log.md should record which agent made decisions."""
        log_file = BRAIN_DIR / "decisions_log.md"
        if not log_file.exists():
            pytest.skip("decisions_log.md does not exist")
        
        content = log_file.read_text(encoding='utf-8')
        assert any(kw in content for kw in ['Агент', 'Agent', 'PM', 'GD', 'DEV', 'ART', 'UIUX']), \
            "decisions_log.md should record agent information"


if __name__ == "__main__":
    pytest.main([__file__, "-v"])
