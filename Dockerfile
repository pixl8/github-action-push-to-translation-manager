FROM pixl8/docker-commandbox-lite:v2-rc
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN box install pixl8/pixl8-commandbox-commands#v2.6.4
RUN box install pixl8-translation-manager-commandbox-commands@0.9.2

ENTRYPOINT ["/entrypoint.sh"]