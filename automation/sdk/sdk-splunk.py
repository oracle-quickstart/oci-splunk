"""A simple example showing how to use the Splunk Client SDK
to get different details using python and saving them to CSV file.
"""

from utils import parse
from splunklib import client
import sys
import os
from csv import writer

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "lib"))


class SplunkDemo():

    def __init__(self, argv):
        """Initialize an Instance of Splunk Env."""
        opts = parse(argv, {}, ".env")
        self.service = client.connect(**opts.kwargs)

    def get_splunk_jobs(self):
        """Get Splunk Jobs."""
        data = local = []
        header = ['name']
        for job in self.service.jobs:
            local = []
            local.extend([job.name])
            data.append(local)

        self.write_data_to_csv_file('sdk-jobs.csv', data, header)

    def get_splunk_apps(self):
        """Get Splunk Apps."""
        data = local = []
        header = ['name']
        for app in self.service.apps:
            local = []
            local.extend([app.name])
            data.append(local)

        self.write_data_to_csv_file('sdk-apps.csv', data, header)

    def get_splunk_searches(self):
        """Get Splunk Searches."""
        data = local = []
        my_saved_search = ""
        header = ['name', 'description', 'search query']
        for search in self.service.saved_searches:
            local = []
            # self.get_splunk_search(self.service.saved_searches, search.name)
            my_saved_search = self.service.saved_searches[search.name]
            local.extend(
                [search.name, my_saved_search["description"], search.search])
            data.append(local)

        self.write_data_to_csv_file('sdk-searches.csv', data, header)

    def get_splunk_search(self, searches, search_name):
        """Get Splunk Search Details."""
        saved_searches = searches
        print(saved_searches.get(search_name))

    def get_splunk_parse(self, searches, search_query):
        """Get Splunk Parser."""
        saved_searches = searches
        print(saved_searches.parse(search_query))

    def get_splunk_loggers(self):
        """Get Splunk Loggers."""
        data = local = []
        header = ['name', 'level']
        for logger in self.service.loggers:
            local = []
            local.extend([logger.name, logger.level])
            data.append(local)
        self.write_data_to_csv_file('sdk-loggers.csv', data, header)

    def get_splunk_alerts(self):
        """Get Splunk Alerts."""
        for group in self.service.fired_alerts:
            print(group)
            header = f"{group.name} (count: {group.count})"
            print(header)
            print('=' * len(header))
            alerts = group.alerts
            for alert in alerts.list():
                content = alert.content
                for key in sorted(content.keys()):
                    value = content[key]
                    print(f"{key}: {value}")
                print()

    def get_splunk_indexes(self):
        """Get Splunk Indexes."""
        data = local = []
        header = ['name', 'index']
        for index in self.service.indexes.list(datatype='all'):
            local = []
            local.extend([index.name])
            data.append(local)

        self.write_data_to_csv_file('sdk-indexes.csv', data, header)

    def get_splunk_inputs(self):
        """Get Splunk Inputs."""
        data = local = []
        header = ['name', 'kind', 'content']
        for item in self.service.inputs:
            local = []
            local.extend([item.name, item.kind, item.content])
            data.append(local)

        self.write_data_to_csv_file('sdk-inputs.csv', data, header)

    def get_splunk_reports(self):
        """Get Splunk Reports."""
        data = local = []
        header = ['name', 'report']
        for report in self.service.saved_reports:
            local = []
            local.extend([report.name, report.search])
            data.append(local)

        self.write_data_to_csv_file('sdk-reports.csv', data, header)

    def get_splunk_operators(self):
        """Get Splunk Operators."""
        for operator in self.service.saved_searches:
            print(operator.name)

    def get_splunk_results(self):
        """Get Splunk Operators."""
        for operator in self.service.saved_searches:
            print(operator.name)

    def write_data_to_csv_file(self, file_name, data, header):
        """Store Values in CSV Files."""
        with open(file_name, 'w', encoding='UTF8', newline='') as write_obj:
            csv_writer = writer(write_obj)
            csv_writer.writerow(header)
            csv_writer.writerows(data)

sdk_class = SplunkDemo(sys.argv[1:])
sdk_class.get_splunk_jobs()
sdk_class.get_splunk_apps()
sdk_class.get_splunk_searches()
sdk_class.get_splunk_loggers()
sdk_class.get_splunk_indexes()
sdk_class.get_splunk_inputs()

# sdk_class.get_splunk_reports()
# sdk_class.get_splunk_alerts()
