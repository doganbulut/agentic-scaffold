import { describe, it, expect } from 'vitest';
import { hello } from '../src/core/hello.js';

describe('hello', () => {
  it('should greet the given name', () => {
    expect(hello('World')).toBe('Hello, World!');
  });

  it('should handle empty string', () => {
    expect(hello('')).toBe('Hello, !');
  });

  it('should handle special characters', () => {
    expect(hello('Alice & Bob')).toBe('Hello, Alice & Bob!');
  });
});
