# Sample GX Project (Containerization)

This demo centers around building and using Docker images to be used with Great Expectations.

## Caveat Emptor

The examples within are meant for education and illustration purposes only. The container images below are not suitable to be deployed on any production system as they are not security/compliance hardened. These are meant to be a good starting point. Please consult with your team/IT/Opsec before you push these images/containers to any production systems.

## Local Deployment

This sample image shows how straight-forward it can be to containerize GX for local development (with bonus how to run a Jupyter notebook from within the container)

To build the local image run:

`docker build -f Dockerfile.local . -t gx/gxdemo:local`

Bearing in mind `gx/gxdemo:local` is what we used for the demo but you should change to whatever `<repo>/<image_name>:<tag>` that makes sense for you. The same applies for the examples below.

To run the container _and_ mount the current directory into the container run the following command:

`docker run -it -v $(pwd):/app gx/gxdemo:local` (again using whatever `<repo>/<image_name>:<tag>` you chose earlier).

## Self-contained Deployment

It is often useful to create an image that has everything it needs without relying on the host in which it was built. To achieve this, we will simply add the `COPY` directive to our `Dockerfile.deploy` so that it will copy the files of the local directory (relative to where the Dockerfile is) to the containers `WORKDIR` (in this case `/app`).

To build this image run this command:

`docker build -f Dockerfile.deploy . -t gx/gxdemo:deploy`

You can then run this image from any host which has a Docker runtime (not necessarily the host in which it was created) with the following command:

`docker run -ti gx/gxdemo:deploy` 

## CI/Github deployment

There is a plethora of ways and patterns in which teams can collaborate and have data quality tests in a CI pipeline. For the sake of brevity and simplicity we are going to assume there is a CI pipeline somewhewre that gets triggered when there's a merge to a repo's main branch. The CI runner will then build the Docker image and then run the container (which will be running the DQ checks on startup).

To note here in `Dockerfile.server` we instruct to clone the repo at image build time.

To build this image run:

`docker build -f Dockerfile.server . -t gx/gxdemo:server` (in a real usage this command would be ran in the CI)

Then, the CI runner would run the container (as follows below) and report relevant results.

`docker run gx/gxdemo:server`

## Bonus (run Jupyter notebook in container and access from your local browser)

In `Dockerfile.local` uncomment (remove the `#`) the line that starts with `# CMD ["jupyter",...` and save the file. Then build the image:

`docker build -f Dockerfile.local . -t gx/gxdemo:local`

After build is complete, run:

`docker run -v $(pwd):/app -p 8888:8888 gx/gxdemo:local`

In the terminal output you should see links to the notebook which you can copy and paste in your local web browser. A full-fledged data quality environment in your browser!

