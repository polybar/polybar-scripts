# Polybar WakaTime status

![](/img/screenshot.png)

Display your daily coding time in [Polybar](https://github.com/polybar/polybar).
## Prerequisites
- [WakaTime](wakatime.com) account and API token 
- Polybar 

## Dependencies

- [jq](https://stedolan.github.io/jq/) for JSON parsing in bash
- [openssl](https://www.openssl.org/)
- curl 

## Security 

There is provision for you to store your WakaTime API key as plain text in the script file but this is not recommended. 

If you wish to encrypt your password and store it separately in another file there is a [helper script](./scripts/token_encrypt.sh) that does this for you. If you choose this option the script will source your password and decrypt it before making the request to WakaTime. This isn't 100% secure but it is safer than storing you unencrypted token in the Polybar script. Obviously store your public password and the file containing the encrypted token in another non-Git directory.  

## Instructions 

### I don't want to encrypt my token 
* Use the script [polybar_wakatime_no-encrypt](/scripts/polybar_wakatime_no-encrypt.sh)
* Change the string `MYTOKEN` to your WakaTime API key
statusbar e
### I want to encrypt my token 
* Make the file [token_encrypt](/scripts/token_encrypt.sh) executable
* Run it and make a note of your decryption password 
* Use the script [polybar_wakatime_encrypt](/scripts/polybar_wakatime_encrypt.sh)
* Change the variable `SECRET_LOC` to the location of the generated secret file
* Change the variable `SSL_PASS` to your decryption password
statusbar e
### Final steps 
Follow standard procedure:
* Save the `polybar_wakatime...` script wherever you keep your scripts in `.config/polybar/`
* Make it executable
* Add the module definition to `polybar/config.ini`:

```ini
[module/wakatime]
type = custom/script
exec = ~/dotfiles/polybar/polybar_scripts/wakatime_status/query_wakatime.sh
interval = 10
; add yer own icon and preferred styling etc 
format-prefix = " "
format-underline = #707f23
format-prefix-foreground = #2f7e25 
label-padding = 1
```
