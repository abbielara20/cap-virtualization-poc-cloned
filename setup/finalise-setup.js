#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const readline = require('readline');

// CLI args
const args = process.argv.slice(2);
const forcePrompt = args.includes('--prompt') || args.includes('-p');
const cleanAfter = args.includes('--clean') || args.includes('-c');

// Paths
const root = process.cwd();
const setupDir = path.join(root, 'setup');
const configFilename = 'setup-config.json';
const configPath = path.join(root, configFilename);
const readmeTemplatePath = path.join(setupDir, 'README.template.md');
const finalReadmePath = path.join(root, 'README.md');
const thisScriptPath = path.join(setupDir, 'finalise-setup.js');

// Files to remove or archive after setup
const setupFiles = [thisScriptPath, readmeTemplatePath, path.join(root, configFilename)];

// Readline
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

// Questions
const questions = [
  {
    key: 'APP_ID',
    question: 'Enter your application ID (no spaces):',
    validate: input => /^[^\s]+$/.test(input) || 'Application ID must not contain whitespace.',
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

// Load existing config
let existingConfig = {};
if (fs.existsSync(configPath)) {
  try {
    existingConfig = JSON.parse(fs.readFileSync(configPath, 'utf8'));
  } catch {
    console.warn('⚠️ Failed to parse setup-config.json. Ignoring.\n');
  }
}

// Prompt logic
function askQuestion(q, i, answers, done) {
  const defaultValue = existingConfig[q.key] || (typeof q.default === 'function' ? q.default(answers) : q.default);
  let prompt = q.question;
  if (defaultValue) prompt += ` [${defaultValue}]`;

  rl.question(prompt + ' ', answer => {
    const finalAnswer = answer.trim() || defaultValue;
    const valid = q.validate(finalAnswer);
    if (valid !== true) {
      console.log(`❌ ${valid}`);
      return askQuestion(q, i, answers, done);
    }
    answers[q.key] = finalAnswer;
    if (i + 1 < questions.length) {
      askQuestion(questions[i + 1], i + 1, answers, done);
    } else {
      done(answers);
    }
  });
}

// Replace placeholders
function replacePlaceholders(dir, variables) {
  fs.readdirSync(dir, { withFileTypes: true }).forEach(entry => {
    const fullPath = path.join(dir, entry.name);
    if (entry.name === 'node_modules' || entry.name === '.setup' || entry.name === 'setup') return;

    if (entry.isDirectory()) {
      replacePlaceholders(fullPath, variables);
    } else {
      let content = fs.readFileSync(fullPath, 'utf8');
      let updated = content;
      for (const [key, value] of Object.entries(variables)) {
        updated = updated.replace(new RegExp(`__${key}__`, 'g'), value);
      }
      if (updated !== content) {
        fs.writeFileSync(fullPath, updated, 'utf8');
        console.log(`✔️ Updated: ${fullPath}`);
      }
    }
  });
}

// Generate README.md
function generateFinalReadme(vars) {
  if (!fs.existsSync(readmeTemplatePath)) {
    console.warn('⚠️ README.template.md not found. Skipping README generation.');
    return;
  }
  let content = fs.readFileSync(readmeTemplatePath, 'utf8');
  for (const [key, value] of Object.entries(vars)) {
    content = content.replace(new RegExp(`__${key}__`, 'g'), value);
  }
  fs.writeFileSync(finalReadmePath, content, 'utf8');
  console.log(`📝 Generated README.md from template.`);
}

// delete setup files
function cleanup() {
  setupFiles.forEach(file => {
    if (fs.existsSync(file)) {
      fs.unlinkSync(file);
      console.log(`🗑️ Deleted ${path.relative(root, file)}`);
    }
  });
  if (fs.existsSync(setupDir)) fs.rmSync(setupDir, { recursive: true, force: true });;
}

// Finalise
function runSetupWithValues(answers) {
  console.log('\n🔄 Replacing placeholders...');
  replacePlaceholders(root, answers);
  generateFinalReadme(answers);
  // fs.writeFileSync(path.join(setupDir, configFilename), JSON.stringify(answers, null, 2), 'utf8');
  fs.rename(configPath, path.join(setupDir, configFilename), () => { return });
  if (cleanAfter) cleanup();
  console.log('\n✅ Setup complete!');
  rl.close();
}

// Entry
function startInteractiveSetup() {
  askQuestion(questions[0], 0, {}, answers => runSetupWithValues(answers));
}

if (fs.existsSync(configPath) && !forcePrompt) {
  console.log('📄 setup-config.json found — running setup silently with saved values.\n');
  runSetupWithValues(existingConfig);
} else {
  if (forcePrompt) {
    console.log('⚙️  --prompt flag detected — running interactive setup.\n');
  }
  startInteractiveSetup();
}
