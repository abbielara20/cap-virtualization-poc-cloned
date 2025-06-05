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
            'srv/.template-placeholder.ts',
        ],
    },
    ...cds.recommended,
    {
        files: ['**/*.ts'],
        languageOptions: {
            parser: parserTs,
            ecmaVersion: 'latest',
            sourceType: 'module',
        },
        plugins: {
            '@typescript-eslint': eslintPluginTs,
        },
        rules: {
            '@typescript-eslint/no-unused-vars': ['warn'],
            '@typescript-eslint/no-explicit-any': 'warn',
            '@typescript-eslint/explicit-function-return-type': ['warn'],
            '@typescript-eslint/consistent-type-definitions': ['warn', 'interface'],
        },
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
        }
    }
]
