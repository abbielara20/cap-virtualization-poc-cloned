# Getting Started

Welcome to your new project.

It contains these folders and files:

File or Folder       | Purpose
---------------------|-------------------------------
`.pipeline/`         | Pipeline deployment configuration
`db/`                | Your domain models and data
`srv/`               | Your service models and code
`package.json`       | Project metadata and configuration
`readme.md`          | This getting started guide
`Jenkinsfile`        | Jenkins pipeline definition

## ⚡️ Quick Start

1. Clone your repo from this template
2. Run: `node setup/finalise-setup.js --clean`
3. Commit and push
4. Run: `cds watch` to start developing


## 🚀 Project Setup

This project was generated from a template. To finalize your project setup, run the setup script from the root of the folder.  You can leave off the --clean argument if you don't want the script to clean up all the setup files.  You can delete the setup/ folder manually.

```
node setup/finalise-setup.js --clean
```

### 🛠 Setup Options

You have **two ways** to run the setup script:

#### 1. Config File Mode (automated)

If you'd prefer to avoid interactive prompts, you can create a `setup-config.json` file in the project root with the following structure:
```json
{
  "APP_ID": "my-new-cap-project",
  "DESCRIPTION": "My new CAP project",
  "REPOSITORY": "zespri-international-ltd/my-new-cap-project"
}
```

A default example already exists. When this file is present, the script will automatically use the values it contains to complete setup without prompting you.

#### 2. Interactive Mode (default)

If no `setup-config.json` file is present (see option 1. automated), you'll be prompted to provide the necessary values:

- `APP_ID` – your application ID (no spaces)
- `DESCRIPTION` – a short description of your project
- `REPOSITORY` – GitHub repository in the format `org/repo`

You can also force prompts by running:

```
node setup/finalise-setup.js --prompt --clean
```
