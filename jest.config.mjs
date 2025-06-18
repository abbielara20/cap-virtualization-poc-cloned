module.exports = {
    // Test environment
    testEnvironment: 'node',

    // Automatically clear mock calls and instances between every test
    clearMocks: true,

    // Collect coverage information
    collectCoverage: true,
    collectCoverageFrom: [
        'srv/**/*.{js,ts}',
        'app/**/*.{js,ts}',
        'db/**/*.{js,ts}',
        '!**/node_modules/**',
        '!**/gen/**',
        '!**/coverage/**',
        '!**/*.d.ts',
        '!**/test/**',
        '!**/tests/**',
        '!**/__tests__/**',
        '!**/mta_archives/**'
    ],

    // Coverage output directory
    coverageDirectory: 'coverage',

    // Coverage reporters
    coverageReporters: [
        'text',
        'lcov',
        'html',
        'cobertura'
    ],

    // Coverage thresholds
    coverageThreshold: {
        global: {
            branches: 70,
            functions: 70,
            lines: 70,
            statements: 70
        }
    },

    // Test file patterns
    testMatch: [
        '**/test/**/*.(js|ts)',
        '**/tests/**/*.(js|ts)',
        '**/__tests__/**/*.(js|ts)',
        '**/*.(test|spec).(js|ts)'
    ],

    // Ignore patterns
    testPathIgnorePatterns: [
        '/node_modules/',
        '/gen/',
        '/mta_archives/',
        '/coverage/',
        '/dist/',
        '/build/'
    ],

    // Module path ignore patterns (fixes the haste map collision)
    modulePathIgnorePatterns: [
        '<rootDir>/gen/',
        '<rootDir>/mta_archives/',
        '<rootDir>/node_modules/',
        '<rootDir>/coverage/'
    ],

    // Transform files
    transform: {
        '^.+\\.(js|jsx)$': 'babel-jest',
        '^.+\\.(ts|tsx)$': 'ts-jest'
    },

    // Setup files to run before tests
    setupFilesAfterEnv: [
        '<rootDir>/test/setup.ts'
    ],

    // Module name mapping for CAP-specific imports
    moduleNameMapping: {
        '^@sap/cds$': '@sap/cds',
        '^@sap/cds/(.*)$': '@sap/cds/$1'
    },

    // Global variables available in tests
    globals: {
        'ts-jest': {
            useESM: false,
            tsconfig: {
                allowJs: true,
                checkJs: false
            }
        }
    },

    // Test timeout (in milliseconds)
    testTimeout: 30000,

    // Pass with no tests (prevents exit code 1 when no tests found)
    passWithNoTests: true,

    // Roots - directories to search for tests and modules
    roots: [
        '<rootDir>/srv',
        '<rootDir>/app',
        '<rootDir>/db',
        '<rootDir>/test',
        '<rootDir>/tests'
    ],

    // Extensions to resolve
    moduleFileExtensions: [
        'js',
        'json',
        'ts',
        'tsx',
        'jsx'
    ],

    // Maximum number of concurrent workers
    maxWorkers: '50%',

    // Reset mocks between tests
    resetMocks: true,

    // Restore mocks after each test
    restoreMocks: true,

    // JUnit XML output for Jenkins
    reporters: [
        'default',
        ['jest-junit', {
            outputDirectory: 'test-results',
            outputName: 'jest-junit.xml',
            classNameTemplate: '{classname}',
            titleTemplate: '{title}',
            ancestorSeparator: ' › ',
            usePathForSuiteName: true
        }]
    ],

    // Watch mode ignore patterns
    watchPathIgnorePatterns: [
        '/node_modules/',
        '/gen/',
        '/mta_archives/',
        '/coverage/'
    ]
};