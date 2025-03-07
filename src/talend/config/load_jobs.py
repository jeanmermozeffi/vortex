import yaml

def get_job_path(job_key):
    with open("/opt/src/talend/config/jobs_mapping.yml", "r") as file:
        jobs = yaml.safe_load(file)["jobs"]
    return jobs.get(job_key, None)
