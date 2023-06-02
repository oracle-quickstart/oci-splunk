# Copyright © 2023, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

""" Library for Splunk integration """

import json
from csv import writer
import requests
import urllib3
import urllib
import xmltodict
from xml.dom import minidom
import xml.etree.ElementTree as ET
from urllib3.exceptions import HTTPError
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


class SplunkRest:
    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def __init__(self, verify_ssl=False):
        """Initialize an Instance of Splunk class."""
        self.auth_token = ""
        self.params = {}
        self.apis = {}
        self.username = ""
        self.password = ""
        self.base_api_url = ""
        self.session = requests.Session()
        self.session.headers.update(
            {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        )

    def generate_auth_token(
        self, base_api_url, username, password, max_records=None
    ):
        """Generate Auth Token for Splunk APIs."""
        self.base_api_url = base_api_url
        self.username = username
        self.password = password
        self._initialize_apis(SplunkRest.api_url(self.base_api_url))
        payload = urllib.parse.urlencode(
            {'username': username, 'password': password})
        response = self.session.post(
            self.apis["auth"], data=payload, verify=False)
        if response.status_code >= 200 and response.status_code < 300:
            dict_data = xmltodict.parse(response.content)
            self.auth_token = dict_data["response"]["sessionKey"]
            self.session.headers.update(
                {
                    "Content-type": "application/json",
                    "Authorization": f"Bearer {self.auth_token}"
                }
            )
            return True
        else:
            raise Exception(json.loads(response.text))

    def list_saved_searches(self):
        """List Saved Searches."""
        response = self.session.get(
            self.apis["savedsearches"] + "?output_mode=json", params=self.params)
        data = local = []
        header = ['name']
        if response.status_code >= 200 and response.status_code < 300:
            for entry in json.loads(response.text)["entry"]:
                local = []
                local.extend([entry["name"]])
                data.append(local)
            return self.write_data_to_csv_file('apis-saved-searches.csv', data, header)
        else:
            raise Exception(json.loads(response.text))
        
    def list_source_types(self):
        """List Data Inputs."""
        response = self.session.get(
            self.apis["sourcetypes"] + "?output_mode=json&count=1000", params=self.params)
        data = local = []
        header = ['name']
        if response.status_code >= 200 and response.status_code < 300:
            for entry in json.loads(response.text)["entry"]:
                local = []
                local.extend([entry["name"]])
                data.append(local)
            return self.write_data_to_csv_file('apis-sourcetypes.csv', data, header)
        else:
            raise Exception(json.loads(response.text))

    def list_data_inputs(self):
        """List Data Inputs."""
        response = self.session.get(
            self.apis["datainputs"] + "?output_mode=json", params=self.params)
        data = local = []
        header = ['name']
        if response.status_code >= 200 and response.status_code < 300:
            for entry in json.loads(response.text)["entry"]:
                local = []
                local.extend([entry["name"]])
                data.append(local)
            return self.write_data_to_csv_file('apis-inputs.csv', data, header)
        else:
            raise Exception(json.loads(response.text))

    def list_local_apps(self):
        """List Local Apps."""
        response = self.session.get(
            self.apis["localapps"] + "?output_mode=json", params=self.params)
        data = local = []
        header = ['name']
        if response.status_code >= 200 and response.status_code < 300:
            for entry in json.loads(response.text)["entry"]:
                local = []
                local.extend([entry["name"]])
                data.append(local)
            return self.write_data_to_csv_file('apis-apps.csv', data, header)
        else:
            raise Exception(json.loads(response.text))

    def write_data_to_csv_file(self, file_name, data, header):
        """Store Values in CSV Files."""
        with open(file_name, 'w', encoding='UTF8', newline='') as write_obj:
            csv_writer = writer(write_obj)
            csv_writer.writerow(header)
            csv_writer.writerows(data)

    @staticmethod
    def api_url(base_api_url):
        """OCI Splunk API Build URL."""
        return base_api_url

    def _initialize_apis(self, api_path):
        """Initialize APIs endpoints required for each functions."""
        self.apis["auth"] = api_path + "/services/auth/login"
        self.apis["datainputs"] = api_path + "/services/data/inputs/all"
        self.apis["localapps"] = api_path + "/services/apps/local"
        self.apis["savedsearches"] = api_path + "/services/saved/searches"
        self.apis["sourcetypes"] = api_path + "/services/saved/sourcetypes"      


init_class = SplunkRest()
init_class.generate_auth_token(
    "XXX", "XXX", "XXX")
init_class.list_local_apps()
init_class.list_data_inputs()
init_class.list_saved_searches()
init_class.list_source_types()