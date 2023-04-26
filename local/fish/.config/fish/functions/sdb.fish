# search a server by fqdn prefix and open it in serverdb
function sdb
    set -l query $argv[1]
    set -l fqdn (cat ~/.cache/servers.txt | grep ^$query | head -1 | xargs)
    if test -n $fqdn
        set -l id (curl -s https://simpleapi.prod.$COMPANY_DOMAIN/servers/$fqdn | jq .server.id)
        open https://serverdb.$COMPANY_DOMAIN/hud/v/servers/server/$id/
    else
        echo "No servers found"
    end
end
