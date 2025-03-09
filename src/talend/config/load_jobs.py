import yaml

def get_job_path(job_key):
    with open("/home/cicbi/vortex/src/talend/config/jobs_mapping.yml", "r") as file:
        jobs = yaml.safe_load(file)["jobs"]
    return jobs.get(job_key, None)
