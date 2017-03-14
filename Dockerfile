FROM alpine:3.5
RUN apk update
RUN apk upgrade
RUN apk --no-cache add ca-certificates
RUN apk --no-cache add --virtual build-dependencies go git musl-dev \
  && mkdir -p /root/gocode \
  && export GOPATH=/root/gocode \
  && go get github.com/mailhog/MailHog \
  && mv /root/gocode/bin/MailHog /usr/local/bin \
  && rm -rf /root/gocode \
  && apk del --purge build-dependencies
RUN adduser -D -u 1000 mailhog
USER mailhog
WORKDIR /home/mailhog
ENTRYPOINT ["MailHog"]
EXPOSE 1025 1080
