#!/usr/bin/env bash
#
# title: Polybar Module - News
# project-home: https://github.com/nivit/polybar-module-news
# license: MIT

##################
# default values #
##################

show_site="yes"  # display the name of the source
use_colors="yes"  # for error/warning

error_bg_color="#F44336"
error_fg_color="#FFFFFF"
warning_bg_color="#FFC107"
warning_fg_color="#212121"

python_cmd=python3.6

################
# start script #
################

module_dir=${HOME}/.config/polybar/scripts/news
module_obj_dir=${module_dir}/obj

feed_file=${module_obj_dir}/news.items
feeds=${module_dir}/rss.feeds
news_conf=${module_dir}/news.conf
rss_lock=${module_obj_dir}/news.lock
rss_py=${module_dir}/download_rss_feeds.py
rss_tpl=${module_dir}/rsstool.tpl
rss_url=${module_obj_dir}/news.url

use_feedparser=0


error_msg() {

    if [ "X${use_colors}X" = "XyesX" ]; then
        echo -n "%{B${error_bg_color} F${error_fg_color}} ${1} %{B- F-}"
    else
        echo -n "${1}"
    fi

    exit 0
}


warning_msg() {

    if [ "X${use_colors}X" = "XyesX" ]; then
        echo -n "%{B${warning_bg_color} F${warning_fg_color}} ${1} %{B- F-}"
    else
        echo -n "${1}"
    fi
}


download_rss() {

    if [ ! -f "${feeds}" ]; then
        error_msg "-- no feeds file found! --"
        exit 0
    fi

    warning_msg "-- Downloading RSS feeds --"

    (touch "${rss_lock}"

    if [ "${use_feedparser}" = "0" ]; then
        rsstool --wget -o "${feed_file}" \
            --txt --input-file="${feeds}" --sdesc \
            --template2="${rss_tpl}" > /dev/null 2>&1
    else
        ${python_cmd} "${rss_py} ${feeds} ${feed_file}"
    fi
    rm "${rss_lock}"
    )

    exit 0
}


setup() {

    # override default values
    if [ -f "${news_conf}" ]; then
        # shellcheck source=news.conf disable=SC1091
        . "${news_conf}"
    fi

    if [ ! -d "${module_obj_dir}" ]; then
        mkdir -p "${module_obj_dir}"
    fi

    if ! rsstool_loc="$(type -p rsstool)" || [[ -z $rsstool_loc ]]; then
        # rsstool is missing, try with python + feedparser
        if ! python_loc="$(type -p ${python_cmd})" || [[ -z $python_loc ]]; then
            error_msg "-- please install rsstool or a python 3 interpreter! --"
        else
            ${python_cmd} -c 'import feedparser' > /dev/null 2>&1

            # shellcheck disable=2181
            if [ $? = 0 ]; then
                use_feedparser=1
            else
                error_msg "-- please install python module feedparser! --"
                exit 0
            fi
        fi
    elif ! wget_loc="$(type -p wget)" || [[ -z $wget_loc ]]; then
        error_msg "-- please install wget! --"
        exit 0
    fi

    if ! xdg_cmd_loc="$(type -p xdg-open)" \
            || [[ -z ${xdg_cmd_loc} ]]; then
        error_msg "-- please install xdg-open program!"
        exit 0
    fi
}


main() {

    if [ -s "${feed_file}" ]; then
        if [ -z "$1" ] && [ ! -f "${rss_lock}" ]; then
            if [ "X${show_site}X" = "XyesX" ]; then
                site=$(sed -n -e '1p' "${feed_file}")": "
            else
                site=""
            fi

            title=$(sed -n -e '2p' "${feed_file}")
            url=$(sed -n -e '3p' "${feed_file}")

            echo "${site}${title}"
            echo -n "${url}" > "${rss_url}"
            sed -i.bak -e '1,3d' "${feed_file}"

            exit 0
        elif [ "$1" = "url" ]; then
            # shellcheck disable=2046
            xdg-open $(cat "${rss_url}")&
            exit 0
        else
            warning_msg "-- Downloading RSS feeds --"
            exit 0
        fi
    else
        download_rss
    fi
}


setup
main "${1}"

