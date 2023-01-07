# cfpages-limits

 * https://developers.cloudflare.com/pages/platform/limits/
 * https://developers.cloudflare.com/cache/about/default-cache-behavior

The `build.sh` script makes a mirror of [https://prunednode.today]()
while splitting the big zip file into many smaller ones to fit in
CloudFlare Pages' limit.

It also always keeps one older version in `files-old.txt`.

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
gpgv: Signature made Mon 03 Oct 2022 06:38:40 PM CEST
gpgv:                using ECDSA key 6F16E354F83393D6E52EC25F36ED357AB24B915F
gpgv: Good signature from "Stepan Snigirev (Specter release signing key) <snigirev.stepan@gmail.com>"
'snapshot221003.zip' => 'latest.zip'
Verifying SHA256 of snapshot221003.zip...
snapshot221003.zip: OK

real	25m4.155s
user	1m8.845s
sys	0m54.804s
```

It takes around 30 minutes on a home 30Mbps DSL connection.


# On-The-Fly

To decompress a zip file on-the-fly, bsdtar from libarchive-tools
shall be used. But also Busybox unzip uses its own implementation of
libarchive and can do it.

Two different scripts were added and they can be used as a replacement
for latest.sh.txt:

  * `bsdtar.sh.txt` - uses bsdtar from libarchive-tools
  * `busybox.sh.txt` - uses busybox


# Deployment

 1. a first time deployment downloads everything from the upstream
    (now prunednode.today) but should take less than 30 minutes
    on Cloud Flare nodes.
 2. any consecutive redeployment (if prunednode.today did not change)
    will download everything from CF and takes a little bit more than
    10 minutes - see below.

```
10:59:43.118	Cloning repository...
10:59:44.130	From https://github.com/carnhofdaki/cfpages-limits
...
11:10:04.957	Success: Assets published!
11:10:05.688	Success: Your site was deployed!
```
