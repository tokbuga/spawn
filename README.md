### Spider for digging web

This project has some tools that necessart for a web spider. Uses a redis database which has dbs':
<table>
<tr><td>db</td><td>for</td><td>example key</td><td>value</td><td>description</td></tr>
<tr><td>0</td><td>domain name</td><td>org.example.any</td><td>org.example</td><td>reversed extracted domain</td></tr>
<tr><td>1</td><td>ip4 address</td><td>2.41.5.1</td><td>org.example</td><td>gathered ip4 address</td></tr>
</table>

## dig-domain

last argument of process is a domain name. Tool will be extract other domains from it's name and dns queries / reverse lookups.

```shell
node dig-domain.js org.example
```