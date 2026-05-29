# Turkish Coach — AI-powered personal Turkish tutor

A Claude Code project that turns Claude into **Tarkan**, your long-term Turkish language coach. Built for people learning Turkish to speak with their partner's family — not for tourists, but for real life.

Tarkan teaches through short daily drills, practical family vocabulary, and tight correction loops. No rigid lesson templates — he follows the conversation.

## What makes this different from Duolingo

- Lessons chain from your last real practice moment, not a fixed curriculum
- Exercises use your actual family context (your partner's name, your baby, dinner table phrases)
- Correction is immediate and targeted — one wrong item gets drilled once, then you move on
- Memory persists across sessions through files, not conversation history

---

## Requirements

- [Claude Code CLI](https://claude.ai/code) installed
- Anthropic subscription (Max recommended — Opus model gives best results)
- `tmux` installed (`brew install tmux`)

---

## Setup

### 1. Clone the repo

```bash
git clone <repo-url> ~/Development/Turkish-Coach
cd ~/Development/Turkish-Coach
```

### 2. Start Claude and let Tarkan set you up

```bash
./start.sh
```

On first run, Tarkan detects that the project hasn't been configured yet and walks you through setup in a short conversation — your name, language, partner's family context, current Turkish level. He writes everything into the config files himself.

That's it. After setup, your first lesson starts automatically.

**Remote access (Claude App on your phone):**
```bash
./start.sh --remote
```
Then open the Claude App and tap the Remote Control option.

---

## Daily use

- Run `./start.sh` to open the session (or `tmux attach -t tarkan` if it's already running)
- Just write something — Tarkan picks up where you left off
- After each session, Tarkan updates `LESSON_TRACKER.md` and writes a memory note automatically

---

## File structure

```
Turkish-Coach/
├── CLAUDE.md           — Session instructions for Claude (don't edit)
├── SOUL.md             — Tarkan's personality and teaching approach (don't edit)
├── USER.md             — Your personal profile (filled in during setup)
├── LESSON_TRACKER.md   — Your lesson state and word list (auto-updated by Tarkan)
├── start.sh            — Session launcher
├── templates/          — Source templates (used by setup, or for manual editing)
└── memory/
    ├── MEMORY.md       — Session note index (auto-updated)
    └── YYYY-MM-DD.md   — Session notes (auto-written by Tarkan)
```

---

## Adapting for your situation

**Different native language:** Set `Explanation language` in `USER.md`. Tarkan will teach in Italian, German, English, French — whatever you set.

**Already have some Turkish:** Edit the Active Phase in `LESSON_TRACKER.md` and add words you already know to the word list.

**No upcoming trip:** Remove the trip section from `USER.md`. Tarkan adapts to long-term learning (Phase 3) automatically.
