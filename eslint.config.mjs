import cds from '@sap/cds/eslint.config.mjs'
import eslintPluginTs from '@typescript-eslint/eslint-plugin'
import parserTs from '@typescript-eslint/parser'

export default [
    {
        ignores: [
            'node_modules/',
            'gen/',
            'target/',
            '_out/',
            '*.db',
            '*.sqlite',
            '*.log',
            'coverage/',
            '.DS_Store',
            'dist/',
            '.vscode/',
            '.idea/',
            '@cds-models',
            'srv/.template-placeholder.ts'
        ]
    },

    // SAP CDS base rules
    ...cds.recommended,

    {
        files: ['**/*.ts'],
        languageOptions: {
            parser: parserTs,
            ecmaVersion: 'latest',
            sourceType: 'module'
        },
        plugins: {
            '@typescript-eslint': eslintPluginTs
        },
        rules: {
            '@typescript-eslint/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
            '@typescript-eslint/no-explicit-any': 'warn',
            '@typescript-eslint/explicit-function-return-type': 'off',
            '@typescript-eslint/consistent-type-definitions': ['warn', 'type'],
            '@typescript-eslint/consistent-type-imports': ['warn', {
                prefer: 'type-imports',
                disallowTypeAnnotations: false
            }]

            // Removed: prefer-optional-chain, prefer-nullish-coalescing (type-aware)
        }
    },

    {
        files: ['test/**/*.ts'],
        languageOptions: {
            parser: parserTs,
            ecmaVersion: 'latest',
            sourceType: 'module',
            globals: {
                describe: 'readonly',
                it: 'readonly',
                expect: 'readonly',
                beforeEach: 'readonly',
                afterEach: 'readonly',
                jest: 'readonly'
            }
        },
        rules: {
            '@typescript-eslint/no-explicit-any': 'off'
        }
    }
]
