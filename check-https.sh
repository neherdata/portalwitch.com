#!/bin/bash
# Check if HTTPS certificate is ready and enable enforcement

echo "Checking HTTPS certificate for portalwitch.com..."

# Try HTTPS connection
if curl -sI https://portalwitch.com --max-time 5 2>&1 | grep -q "200 OK"; then
    echo "✅ HTTPS certificate is ready!"

    # Enable HTTPS enforcement
    echo "Enabling HTTPS enforcement..."
    gh api repos/neherdata/portalwitch.com/pages -X PUT -f https_enforced=true

    if [ $? -eq 0 ]; then
        echo "✅ HTTPS redirect enabled!"
        echo "Site now redirects HTTP → HTTPS"
    else
        echo "❌ Failed to enable HTTPS enforcement"
    fi
else
    echo "⏳ Certificate not ready yet. GitHub is still provisioning."
    echo "This usually takes 10-30 minutes for new custom domains."
    echo "Run this script again in a few minutes."
fi
