# House Style System Location

**Location:** `~/Documents/LLM-CLI projects/.house-style/`

The house style framework for all LaTeX papers is installed in the parent directory, one level up from this project.

## Quick Start

**Create a new paper:**

```bash
cd ~/Documents/LLM-CLI\ projects/
.house-style/templates/agents/create-paper.sh "Your Paper Title"
```

## What's Installed

```
~/Documents/LLM-CLI projects/
├── .house-style/                    # Central house style
│   ├── VERSION                      # 1.0.0
│   ├── README.md                    # Documentation
│   ├── preamble.tex                 # LaTeX preamble
│   ├── style-rules.yaml             # Machine-readable rules
│   ├── style-guide.md               # Human-readable guide
│   └── templates/
│       ├── paper-template/          # Template for new papers
│       └── agents/
│           └── create-paper.sh      # Project creation script
│
├── Functions_as_Comparanda.../      # This project (was the prototype)
├── New_Paper_1/                     # Future papers created from template
└── New_Paper_2/                     # etc.
```

## Documentation

- **System Design:** See `docs/plans/2025-11-07-house-style-system-design.md`
- **Workflow Guide:** See `docs/WORKFLOW-GUIDE.md`
- **House Style Guide:** See `../.house-style/style-guide.md`
- **Style Rules (YAML):** See `../.house-style/style-rules.yaml`

## Version

This project was created before the house style system existed. It uses the conventions that became house style v1.0.0.

To adopt the house style system in this project (optional):

```bash
# 1. Copy snapshot
mkdir -p .house-style
cp ../.house-style/preamble.tex .house-style/
cp ../.house-style/style-rules.yaml .house-style/
echo "1.0.0" > .house-style-version

# 2. Update main.tex to use preamble
# Replace current preamble lines with:
# \input{.house-style/preamble.tex}

# 3. Commit changes
git add .house-style .house-style-version
git commit -m "Adopt house style system v1.0.0"
```

## Updates

To update this project's house style snapshot:

```bash
cp ../.house-style/preamble.tex .house-style/
cp ../.house-style/style-rules.yaml .house-style/
# Update .house-style-version if desired
```

**Caution:** Only update if paper is in active development, not if under review or published.
