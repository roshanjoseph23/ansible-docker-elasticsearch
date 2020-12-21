Creating an Elasticsearch container using Ansible and Dockerfile

## Prerequisites

 - AWS programmatic access
 - key pair

## Features

 - Ansible
 - Dockerfile
 - AWS
 - t2.medium EC2 

## ubuntu.yml

 1. Creates an Ubuntu EC2 instance
 2. Creates an Inventory for SSH access
 3. Update apt packages
 4. Install required packages for installation of Docker and npm
 5. Add Docker repository
 6. Install Python Docker module using pip
 7. Add ubuntu user to docker group for non-root docker sessions
 8. Create a temporary elasticsearch directory in `/home/ubuntu`
 9. Copies the `Dockerfile` and required files to `/home/ubuntu/elasticsearch/`
 10. Builds `elasticsearch` image with name `roshanjoseph23/esimage:v1` using `Dockerfile`
 11. Creates a Docker volume `esdata` 
 12. Start  `elasticsearch` container from the image `roshanjoseph23/esimage:v1`

    ports:
    - "9200:9200"
Container port 9200 is bind to EC2 port 9200

## Sample Output

http://</ip/>:9200/

    {
      "name" : "049a6f5d98b3",
      "cluster_name" : "docker-cluster",
      "cluster_uuid" : "kQw5ErHpQGOncdMVy4JoWw",
      "version" : {
        "number" : "7.10.1",
        "build_flavor" : "default",
        "build_type" : "deb",
        "build_hash" : "1c34507e66d7db1211f66f3513706fdf548736aa",
        "build_date" : "2020-12-05T01:00:33.671820Z",
        "build_snapshot" : false,
        "lucene_version" : "8.7.0",
        "minimum_wire_compatibility_version" : "6.8.0",
        "minimum_index_compatibility_version" : "6.0.0-beta1"
      },
      "tagline" : "You Know, for Search"
    }
