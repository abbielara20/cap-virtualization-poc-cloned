## 🔍 Summary

<!-- Briefly describe what this PR changes, fixes, or adds -->

---

## ✅ Checklist

- [ ] I have tested these changes locally using `cds watch` or equivalent
- [ ] I have written or updated relevant unit tests
- [ ] I have run `npm test` and all tests pass
- [ ] I have linted the code (`npm run lint` or equivalent)

---

## 🧪 CI/CD Behaviour

> ⚠️ **This PR will not trigger a Cloud Foundry deploy**

Jenkins will:
- Run build, lint and unit tests only
- **Skip deployment** — deployment occurs only on merge to:
  - `develop` → Dev environment
  - `release/*` → Pre-Prod
  - `main` → Prod

---

## 📌 Notes for Reviewers

<!-- Optional: anything you'd like the reviewer to focus on, or known limitations -->

