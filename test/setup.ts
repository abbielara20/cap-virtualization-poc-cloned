// test/setup.ts
const cds = require('@sap/cds');

// Global test setup
beforeAll(async () => {
    // Initialize CDS for testing
    process.env.NODE_ENV = 'test';

    // Mock authentication for tests
    cds.env.requires.auth = { kind: 'mocked' };

    // Use in-memory database for tests
    cds.env.requires.db = { kind: 'sqlite', credentials: { url: ':memory:' } };

    // Set test timeout
    jest.setTimeout(30000);
});

afterAll(async () => {
    // Cleanup after tests
    if (cds.shutdown) {
        await cds.shutdown();
    }
});

// Global test utilities
(global as any).expect = require('expect');

// Suppress console logs during tests unless explicitly needed
if (process.env.NODE_ENV === 'test' && !process.env.VERBOSE_TESTS) {
    console.log = jest.fn();
    console.info = jest.fn();
    console.warn = jest.fn();
}