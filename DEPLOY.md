# Deployment Guide

## Quick Start

Follow these steps to deploy your Swear Counter to GitHub Pages:

### 1. Create a GitHub Repository

1. Go to https://github.com/new
2. Name your repository (e.g., `swear-counter`)
3. Make it public (required for free GitHub Pages)
4. Do NOT initialize with README (we already have one)
5. Click "Create repository"

### 2. Push Your Code

Replace `YOUR_USERNAME` and `YOUR_REPO_NAME` with your actual GitHub username and repository name:

```bash
# Stage all files
git add .

# Create initial commit
git commit -m "Initial commit: Swear counter app with GitHub Pages deployment"

# Set main as default branch
git branch -M main

# Add GitHub as remote origin
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git

# Push to GitHub
git push -u origin main
```

### 3. Enable GitHub Pages

1. Go to your repository on GitHub
2. Click on "Settings" (top menu)
3. Click on "Pages" in the left sidebar (under "Code and automation")
4. Under "Build and deployment":
   - Source: Select **"GitHub Actions"** (not "Deploy from a branch")
5. Click "Save" if needed

### 4. Wait for Deployment

1. Go to the "Actions" tab in your repository
2. You should see a workflow run called "Deploy to GitHub Pages"
3. Wait for it to complete (usually takes 1-2 minutes)
4. Your site will be live at: `https://YOUR_USERNAME.github.io/YOUR_REPO_NAME/`

## Automatic Deployment

Once set up, every time you push to the main branch, the site will automatically redeploy:

```bash
# Make changes to index.html or other files
git add .
git commit -m "Update: description of changes"
git push
```

## Troubleshooting

### Workflow Not Running?
- Check that GitHub Actions is enabled in Settings > Actions > General
- Ensure the workflow file is at `.github/workflows/deploy.yml`

### 404 Error?
- Make sure GitHub Pages source is set to "GitHub Actions"
- Check that the workflow completed successfully in the Actions tab
- Wait a few minutes, deployment can take time

### Permission Denied?
- Make sure you have the correct repository URL
- Check that you're authenticated with GitHub (use `gh auth login` or set up SSH keys)

## Manual Deployment

If you need to redeploy without making changes:

1. Go to the "Actions" tab
2. Click "Deploy to GitHub Pages" workflow
3. Click "Run workflow" button
4. Select the "main" branch
5. Click "Run workflow"

## Need Help?

- GitHub Pages documentation: https://docs.github.com/en/pages
- GitHub Actions documentation: https://docs.github.com/en/actions
