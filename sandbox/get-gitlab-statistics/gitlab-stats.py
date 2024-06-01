import requests

GITLAB_URL = <url>
PRIVATE_TOKEN = <token>
API_ENDPOINT = '/api/v4/projects?statistics=true'

# Headers for the request
headers = {'PRIVATE-TOKEN': PRIVATE_TOKEN}

# Start with the first page
next_page = 1

while next_page is not None:
    response = requests.get(f"{GITLAB_URL}{API_ENDPOINT}&page={next_page}", headers=headers)
    projects = response.json()

    for project in projects:
        project_name = project['name']
        project_id = project['id']
        project_size = project['statistics']['repository_size']
        if project_size >= 1000000000:
            print(project_name, project_id, project_size)

    # Get the next page if it exists
    next_page = response.headers.get('X-Next-Page')

    # If X-Next-Page is empty, break the loop
    if not next_page:
        break
