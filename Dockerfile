FROM swr.ap-southeast-3.myhuaweicloud.com/livechamp-sgp-v2/base/jdk:v8-jre
ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8 \
    LC_ALL=C.UTF-8 

COPY --from=apache/skywalking-java-agent:8.11.0-alpine /skywalking/agent /skywalking/agent

ADD target/xxl-job-admin-*.jar /app/app.jar
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
&& echo "$TZ" > /etc/timezone \
&& mkdir -p /medium/audio \
&& mkdir -p /data/applogs/xxl-job/ \
&& touch /data/applogs/xxl-job/xxl-job-admin.log \
&& chown -R api:api /app /medium/audio  /data/applogs/xxl-job
WORKDIR /app
USER api
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","app.jar","--spring.profiles.active=prod-sgp-v2"]
