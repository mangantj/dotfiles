source ~/.cf2_secrets
eval "$(/opt/homebrew/bin/brew shellenv)"
export DEVELOPER_HAPPINESS=true

alias cf="itomate -c ~/.cf2.yml"
alias cf_tunnel="cloudflared tunnel run --url http://localhost:5010 tylermanganlocaldev"