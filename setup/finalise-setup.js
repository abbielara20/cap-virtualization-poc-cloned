#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const readline = require('readline');
const { promisify } = require('util');

class SetupManager {
  constructor(rootPath) {
    this.root = rootPath;
    this.setupDir = path.join(rootPath, 'setup');
    this.configFilename = 'setup-config.json';
    this.configPath = path.join(rootPath, this.configFilename);
    this.readmeTemplatePath = path.join(this.setupDir, 'README.template.md');
    this.finalReadmePath = path.join(rootPath, 'README.md');
    this.thisScriptPath = path.join(this.setupDir, 'finalise-setup.js');

    this.setupFiles = [
      this.thisScriptPath,
      this.readmeTemplatePath,
      this.configPath
    ];

    this.templatePlaceholderFiles = [
      'srv/.template-placeholder.ts',
      'test/_template-placeholder.test.ts'
    ];

    this.questions = [
      {
        key: 'APP_ID',
        question: 'Enter your application ID (lowercase, hyphens allowed):',
        validate: input => /^[a-z][a-z0-9-]*$/.test(input) ||
          'App ID must start with letter, contain only lowercase letters, numbers, and hyphens.',
      },
      {
        key: 'DESCRIPTION',
        question: 'Enter a short project description:',
        validate: input => input.length > 0 || 'Description cannot be empty.',
      },
      {
        key: 'REPOSITORY',
        question: 'Enter repository name:',
        default: answers => `zespri-international-ltd/${answers.APP_ID}`,
        validate: input => /^[\w.-]+\/[\w.-]+$/.test(input) || 'Must be in format org/repo.',
      },
    ];
  }

  loadExistingConfig() {
    if (!fs.existsSync(this.configPath)) {
      return {};
    }

    try {
      const content = fs.readFileSync(this.configPath, 'utf8');
      return JSON.parse(content);
    } catch (error) {
      console.warn('WARNING: Failed to parse setup-config.json. Starting fresh.\n');
      return {};
    }
  }

  async askQuestion(prompt) {
    const rl = readline.createInterface({
      input: process.stdin,
      output: process.stdout,
    });

    const question = promisify(rl.question).bind(rl);

    try {
      const answer = await question(`${prompt} `);
      return answer;
    } finally {
      rl.close();
    }
  }

  async collectAnswers(existingConfig = {}) {
    const answers = {};

    console.log('Setting up your CAP project...\n');

    for (const q of this.questions) {
      let answer;
      let attempts = 0;
      const maxAttempts = 3;

      do {
        if (attempts >= maxAttempts) {
          throw new Error(`Too many invalid attempts for ${q.key}. Setup cancelled.`);
        }

        const defaultValue = existingConfig[q.key] ||
          (typeof q.default === 'function' ? q.default(answers) : q.default);

        const promptText = defaultValue ?
          `${q.question} [${defaultValue}]` :
          q.question;

        const rawAnswer = await this.askQuestion(promptText);
        answer = rawAnswer.trim() || defaultValue;

        if (!answer) {
          console.log('ERROR: Answer cannot be empty.');
          attempts++;
          continue;
        }

        const validation = q.validate(answer);
        if (validation !== true) {
          console.log(`ERROR: ${validation}`);
          attempts++;
          answer = null;
        }
      } while (!answer);

      answers[q.key] = answer;
    }

    return answers;
  }

  replacePlaceholders(variables) {
    console.log('Replacing placeholders in project files...');
    let filesUpdated = 0;

    const processDirectory = (dir) => {
      const entries = fs.readdirSync(dir, { withFileTypes: true });

      for (const entry of entries) {
        const fullPath = path.join(dir, entry.name);

        // Skip certain directories
        if (entry.isDirectory()) {
          if (['node_modules', '.setup', 'setup', '.git'].includes(entry.name)) {
            continue;
          }
          processDirectory(fullPath);
        } else {
          // Process file
          try {
            const content = fs.readFileSync(fullPath, 'utf8');
            let updated = content;

            for (const [key, value] of Object.entries(variables)) {
              updated = updated.replace(new RegExp(`__${key}__`, 'g'), value);
            }

            if (updated !== content) {
              fs.writeFileSync(fullPath, updated, 'utf8');
              console.log(`  Updated: ${path.relative(this.root, fullPath)}`);
              filesUpdated++;
            }
          } catch (error) {
            console.warn(`  WARNING: Could not process ${fullPath}: ${error.message}`);
          }
        }
      }
    };

    processDirectory(this.root);
    console.log(`Updated ${filesUpdated} files with project variables.\n`);
  }

  generateReadme(variables) {
    console.log('Generating project README...');

    if (!fs.existsSync(this.readmeTemplatePath)) {
      console.warn('WARNING: README.template.md not found. Skipping README generation.\n');
      return;
    }

    try {
      let content = fs.readFileSync(this.readmeTemplatePath, 'utf8');

      for (const [key, value] of Object.entries(variables)) {
        content = content.replace(new RegExp(`__${key}__`, 'g'), value);
      }

      fs.writeFileSync(this.finalReadmePath, content, 'utf8');
      console.log('README.md generated from template.\n');
    } catch (error) {
      console.error(`ERROR: Failed to generate README: ${error.message}\n`);
    }
  }

  removeTemplateFiles() {
    console.log('Removing template placeholder files...');
    let filesRemoved = 0;

    for (const filePath of this.templatePlaceholderFiles) {
      const fullPath = path.join(this.root, filePath);

      if (fs.existsSync(fullPath)) {
        try {
          fs.unlinkSync(fullPath);
          console.log(`  Removed: ${filePath}`);
          filesRemoved++;
        } catch (error) {
          console.warn(`  WARNING: Failed to remove ${filePath}: ${error.message}`);
        }
      }
    }

    if (filesRemoved > 0) {
      console.log(`Removed ${filesRemoved} template files.\n`);
    } else {
      console.log('No template files to remove.\n');
    }
  }

  cleanup() {
    console.log('Cleaning up setup files...');
    let filesRemoved = 0;

    // Move config to setup directory before cleanup
    if (fs.existsSync(this.configPath)) {
      try {
        const backupPath = path.join(this.setupDir, this.configFilename);
        fs.renameSync(this.configPath, backupPath);
        console.log(`  Moved config to: ${path.relative(this.root, backupPath)}`);
      } catch (error) {
        console.warn(`  WARNING: Could not backup config: ${error.message}`);
      }
    }

    // Remove setup files
    for (const file of this.setupFiles) {
      if (fs.existsSync(file)) {
        try {
          fs.unlinkSync(file);
          console.log(`  Removed: ${path.relative(this.root, file)}`);
          filesRemoved++;
        } catch (error) {
          console.warn(`  WARNING: Failed to remove ${file}: ${error.message}`);
        }
      }
    }

    // Remove setup directory if empty
    if (fs.existsSync(this.setupDir)) {
      try {
        const remaining = fs.readdirSync(this.setupDir);
        if (remaining.length === 0 || (remaining.length === 1 && remaining[0] === this.configFilename)) {
          fs.rmSync(this.setupDir, { recursive: true, force: true });
          console.log(`  Removed setup directory`);
        } else {
          console.log(`  Setup directory kept (contains: ${remaining.join(', ')})`);
        }
      } catch (error) {
        console.warn(`  WARNING: Could not remove setup directory: ${error.message}`);
      }
    }

    console.log(`Cleanup completed.\n`);
  }

  async runSetup(variables) {
    console.log('\n Starting project setup...\n');

    // Show setup progress
    const steps = [
      { name: 'Replace placeholders', fn: () => this.replacePlaceholders(variables) },
      { name: 'Generate README', fn: () => this.generateReadme(variables) },
      { name: 'Remove template files', fn: () => this.removeTemplateFiles() }
    ];

    for (const step of steps) {
      try {
        step.fn();
      } catch (error) {
        console.error(`❌ Failed during ${step.name}: ${error.message}`);
        throw error;
      }
    }

    console.log(' Project setup completed successfully!');
    console.log(` Your project is ready in: ${this.root}`);
    console.log('\n Next steps:');
    console.log('  1. Review the generated README.md');
    console.log('  2. Commit your initial changes');
    console.log('  3. Create a develop branch for GitFlow');
    console.log('  4. Start building your CAP service!\n');
  }
}

// CLI argument parsing
function parseArguments() {
  const args = process.argv.slice(2);
  return {
    forcePrompt: args.includes('--prompt') || args.includes('-p'),
    cleanAfter: args.includes('--clean') || args.includes('-c'),
    help: args.includes('--help') || args.includes('-h')
  };
}

function showHelp() {
  console.log(`
🔧 CAP Project Setup Script

Usage: node finalise-setup.js [OPTIONS]

Options:
  -p, --prompt    Force interactive setup (ignore existing config)
  -c, --clean     Remove setup files after completion
  -h, --help      Show this help message

Examples:
  node finalise-setup.js              # Use existing config or prompt if none
  node finalise-setup.js --prompt     # Always prompt for values
  node finalise-setup.js --clean      # Clean up after setup
  node finalise-setup.js -p -c        # Prompt and clean up

The script will:
  1. Load existing configuration or prompt for project details
  2. Replace template placeholders throughout the project
  3. Generate README.md from template
  4. Remove template placeholder files
  5. Optionally clean up setup files
`);
}

// Main execution
async function main() {
  const options = parseArguments();

  if (options.help) {
    showHelp();
    return;
  }

  const manager = new SetupManager(process.cwd());

  try {
    const existingConfig = manager.loadExistingConfig();
    let variables;

    // Determine whether to use existing config or prompt
    const hasExistingConfig = Object.keys(existingConfig).length > 0;
    const shouldPrompt = options.forcePrompt || !hasExistingConfig;

    if (shouldPrompt) {
      if (options.forcePrompt && hasExistingConfig) {
        console.log('--prompt flag detected — running interactive setup.\n');
      } else if (!hasExistingConfig) {
        console.log('No existing configuration found — starting interactive setup.\n');
      }
      variables = await manager.collectAnswers(existingConfig);
    } else {
      console.log('Using existing configuration from setup-config.json\n');
      variables = existingConfig;
    }

    // Run the setup process
    await manager.runSetup(variables);

    // Clean up if requested
    if (options.cleanAfter) {
      manager.cleanup();
    } else {
      console.log('Setup files preserved. Use --clean flag to remove them.');
    }

  } catch (error) {
    console.error(`\n❌ Setup failed: ${error.message}`);
    console.error('Please check the error above and try again.\n');
    process.exit(1);
  }
}

// Handle process termination gracefully
process.on('SIGINT', () => {
  console.log('\n\n⚠️ Setup cancelled by user.');
  process.exit(0);
});

process.on('uncaughtException', (error) => {
  console.error('\n❌ Unexpected error:', error.message);
  process.exit(1);
});

// Run the script
if (require.main === module) {
  main();
}

module.exports = { SetupManager };