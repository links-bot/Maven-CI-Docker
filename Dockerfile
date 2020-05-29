FROM maven:3-amazoncorretto-11

RUN yum install -y unzip
RUN yum install -y git
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

RUN curl "https://dl.google.com/go/go1.14.3.linux-amd64.tar.gz" -o "go1.14.3.linux-amd64.tar.gz" \
    && tar -C /usr/local -xzf go1.14.3.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"

RUN go get -u github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login

ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
CMD ["mvn"]