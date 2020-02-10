FROM jsturtevant/fluentd

COPY custom/ /fluent/config/custom/

# RUN  C:/opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-cloudwatch-logs


ENTRYPOINT ["cmd", "/k", "C:\\opt\\td-agent\\embedded\\bin\\fluentd", "-c", "C:\\fluent\\conf\\fluent.conf"]