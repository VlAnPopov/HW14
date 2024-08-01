#!/bin/bash
apt update
apt upgrade -y
# Ставим prometheus
apt -y install prometheus
cp -f /vagrant/prometheus.yml /etc/prometheus/
systemctl restart prometheus

apt install  -y libfontconfig1 musl
echo "Ищем пакет"
if [ -f /vagrant/packets/grafana-enterprise_11.1.3_amd64.deb ]
    then
        dpkg -i /vagrant/packets/grafana-enterprise_11.1.3_amd64.deb
    else 
        wget  https://dl.grafana.com/enterprise/release/grafana-enterprise_11.1.3_amd64.deb
        dpkg -i grafana-enterprise_11.1.3_amd64.deb
fi
apt install  -yf
# cp -f /vagrant/grafana.ini /etc/grafana
cp -f /vagrant/promdatasource.yml /etc/grafana/provisioning/datasources
cp -f /vagrant/My_dashboard.json /vagrant/default.yaml /etc/grafana/provisioning/dashboards
systemctl enable --now grafana-server

wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu22.04_all.deb
dpkg -i zabbix-release_7.0-2+ubuntu22.04_all.deb
apt update 
apt install -y zabbix-agent
cp -f /vagrant/zabbix_agentd.conf /etc/zabbix/
systemctl restart zabbix-agent
systemctl enable zabbix-agent 