FROM fluent/fluentd:v1.9-windows-1

RUN gem install kubeclient -v 4.6.0 \
 && gem install fluent-plugin-kubernetes_metadata_filter -v 2.4.2  \
 && gem install fluent-plugin-multi-format-parser -v 1.0.0 \
&& gem install fluent-plugin-cloudwatch-logs -v 0.8.0 \
&& gem install fluent-plugin-concat -v 2.4.0 \
# && gem install fluent-plugin-systemd -v 1.0.2 \
&& gem sources --clear-all

COPY fluent.conf /fluent/conf/fluent.conf
COPY custom/ /fluent/config/custom/

ENV FLUENTD_CONF="fluent.conf"

EXPOSE 24224 5140

ENTRYPOINT ["cmd", "/k", "fluentd", "-c", "C:\\fluent\\conf\\fluent.conf"]