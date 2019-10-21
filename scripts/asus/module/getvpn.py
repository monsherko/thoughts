import argparse
import base64
import requests
import json
import time
headers = {
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0',
    'Referer': '',
    'Upgrade-Insecure-Requests': '1',

}

cookies = {
    'asus_token': '',
    'traffic_warning_0': '2018.4:1',
}

    #тут настройки впн
data = ['current_page=Advanced_VPN_OpenVPN.asp&' + \
        'next_page=Advanced_VPN_OpenVPN.asp&' + \
        'modified=0&action_mode=apply&' + \
        'action_wait=10&' + \
        'action_script=restart_openvpnd%3Brestart_chpass%3Brestart_samba&' + \
        'preferred_lang=EN&'+ \
        'firmver=3.0.0.4&' + \
        'VPNServer_enable=1&' + \
        'VPNServer_mode=pptpd&' + \
        'vpn_serverx_clientlist=' ,
        '&vpn_serverx_eas=1%2C&vpn_serverx_dns=1%2C&'+\
        'vpn_server_ccd_val=&'+\
        'vpn_server_clientlist_username=&'+\
        'vpn_server_clientlist_password=&'+\
        'vpn_server_unit=1&'+\
        'vpn_server_x_eas=1&'+\
        'vpn_server_if=tun&'+\
        'vpn_server_proto=tcp&'+\
        'vpn_server_port=6546&'+\
        'vpn_server_firewall=auto&'+\
        'vpn_server_crypt=tls&'+\
        'vpn_server_igncrt=0&'+\
        'vpn_server_hmac=-1&'+\
        'vpn_server_sn=192.168.0.0&'+\
        'vpn_server_nm=255.255.255.0&'+\
        'vpn_server_dhcp=1&'+\
        'vpn_server_r1=192.168.1.50&'+\
        'vpn_server_r2=192.168.1.55&'+\
        'vpn_server_local=10.8.0.1&'+\
        'vpn_server_remote=10.8.0.2&'+\
        'vpn_server_poll=0&'+\
        'vpn_server_plan=1&'+\
        'vpn_server_rgw=1&'+\
        'vpn_server_x_dns=1&'+\
        'vpn_server_pdns=1&'+\
        'vpn_server_cipher=AES-128-CBC&' +\
        'vpn_server_comp=adaptive&'+\
        'vpn_server_reneg=-1&'+\
        'vpn_server_ccd=0&'+\
        'vpn_server_c2c=0&'+\
        'vpn_server_ccd_excl=0&'+\
        'vpn_clientlist_commonname_0=&'+\
        'vpn_clientlist_subnet_0=&'+\
        'vpn_clientlist_netmask_0=&'+\
        'vpn_clientlist_push_0=0&'+\
        'vpn_server_custom=sndbuf+0%0D%0Arcvbuf+0%0D%0Apush+%22sndbuf+0%22%0D%0Apush+%22rcvbuf+0%22%0D%0Atun-mtu+1500%0D%0Amssfix+1500%0D%0Apush++%22dhcp-option+DNS+193.213.112.4%22%0D%0Aping-timer-rem%0D%0Averb+0']

get_cdata = 'group_id=&'+\
    'action_mode=&'+\
    'action_script=&'+\
    'action_wait=5&'+\
    'current_page=Main_Login.asp&'+\
    'next_page=index.asp&'+\
    'login_authorization='

filepath = '/root/'

def set_vpn(urladdr, vpn_login, vpn_password, filename):
    response = requests.post(urladdr + 'start_apply.htm', headers=headers, cookies=cookies, data=data[0] + '%3C' + vpn_login + '%3E' + vpn_password + data[1], verify=False)
    headers['Referer'] = urladdr + 'Advanced_VPN_OpenVPN.asp'
    time.sleep(3)
    response = requests.get(urladdr + 'client.ovpn', headers=headers, cookies=cookies, verify=False)

    with open(str(filepath + filename), 'w') as fileObj:
        fileObj.write(response.text)

        #print(response.text)

def main():
    parser = argparse.ArgumentParser(description='generic config file for openvpn')
    parser.add_argument('-addr', "--host", type=str)
    parser.add_argument('-p', "--port", type=int)
    parser.add_argument('-a', "--login_authorization", type=str)
    parser.add_argument('-n', "--namefile", type=str, default="client.ovpn")
    parser.add_argument('-vl', "--vpn_login",type=str)
    parser.add_argument('-vp', "--vpn_password", type=str)
    args = parser.parse_args()

    urladdr = 'http://' + str(args.host) + ':' + str(args.port) + '/'
    headers['Referer'] = urladdr + str('Main_Login.asp')
    #  авторизация
    response = requests.post(urladdr + str('login.cgi'), headers=headers,
                                                         data='group_id=&'+\
                                                         'action_mode=&'+\
                                                         'action_script=&'+\
                                                         'action_wait=5&'+\
                                                         'current_page=Main_Login.asp&'+\
                                                         'next_page=index.asp&'
                                                         'login_authorization=' + \
                                                         str(base64.b64encode(args.login_authorization.encode('utf-8'))).split('\'')[1],
                                                         verify=False)

    cookies['asus_token'] = response.headers['Set-Cookie'].split(';')[0].split('=')[1]

    # установка впн, и запись в файл
    set_vpn(urladdr, args.vpn_login, args.vpn_password, args.namefile)

if __name__ == "__main__":
    main()
