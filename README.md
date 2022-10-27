# cfpages-limits

 * https://developers.cloudflare.com/pages/platform/limits/

## Example use

```
$ time sh latest.sh.txt
Processing file latest.zip.03.10.2022.aaaaaaa... (0%)
Processing file latest.zip.03.10.2022.aaaaaab... (0%)
Processing file latest.zip.03.10.2022.aaaaaac... (1%)
Processing file latest.zip.03.10.2022.aaaaaad... (1%)
...
Processing file latest.zip.03.10.2022.aaaaaid... (98%)
Processing file latest.zip.03.10.2022.aaaaaie... (99%)
Processing file latest.zip.03.10.2022.aaaaaif... (99%)
Processing file latest.zip.03.10.2022.aaaaaig... (100%)
latest.zip
Downloading latest.signed.txt ...
gpg: Signature made Mon 03 Oct 2022 06:38:40 PM CEST
gpg:                using ECDSA key 6F16E354F83393D6E52EC25F36ED357AB24B915F
gpg: /tmp/tmp.77edpUvJzE/trustdb.gpg: trustdb created
gpg: Good signature from "Stepan Snigirev (Specter release signing key) <snigirev.stepan@gmail.com>" [expired]
gpg: Note: This key has expired!
Primary key fingerprint: 6F16 E354 F833 93D6 E52E  C25F 36ED 357A B24B 915F
'snapshot221003.zip' => 'latest.zip'
Verifying SHA256 of snapshot221003.zip...
snapshot221003.zip: OK

real	25m4.155s
user	1m8.845s
sys	0m54.804s
```

It takes around 30 minutes on a home 30Mbps DSL connection.
