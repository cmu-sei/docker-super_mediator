[![Software Engineering Institute](https://avatars.githubusercontent.com/u/12465755?s=200&v=4)](https://www.sei.cmu.edu/)

[![Blog](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=Blog)](https://insights.sei.cmu.edu/blog/ "blog posts from our experts in Software Engineering.")
[![Youtube](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=Youtube&logo=youtube)](https://www.youtube.com/@TheSEICMU/ "vidoes from our experts in Software Engineering.")
[![Podcasts](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=Podcasts&logo=applepodcasts)](https://insights.sei.cmu.edu/podcasts/ "podcasts from our experts in Software Engineering.")
[![GitHub](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=GitHub&logo=github)](https://github.com/cmu-sei "view the source for all of our repositories.")
[![Flow Tools](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=Flow%20Tools)](https://tools.netsa.cert.org/ "documentation and source for all our flow collection and analysis tools.")


At the [SEI](https://www.sei.cmu.edu/), we research software engineering, cybersecurity, and AI engineering problems; create innovative technologies; and put solutions into practice.

Find us at:

* [Blog](https://insights.sei.cmu.edu/blog/) - blog posts from our experts in Software Engineering.
* [Youtube](https://www.youtube.com/@TheSEICMU/) - vidoes from our experts in Software Engineering.
* [Podcasts](https://insights.sei.cmu.edu/podcasts/) - podcasts from our experts in Software Engineering.
* [GitHub](https://github.com/cmu-sei) - view the source for all of our repositories.
* [Flow Tools](https://tools.netsa.cert.org/) - documentation and source for all our flow collection and analysis tools.

# [super_mediator](https://tools.netsa.cert.org/super_mediator1/index.html)


[![CI](https://img.shields.io/github/actions/workflow/status/cmu-sei/docker-super_mediator/release.yml?style=for-the-badge&logo=github)](https://github.com/cmu-sei/docker-super_mediator/actions?query=workflow%3ARelease) [![Docker pulls](https://img.shields.io/docker/pulls/cmusei/super_mediator?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/cmusei/super_mediator/)

 super_mediator is an IPFIX mediator for use with the [yaf](http://tools.netsa.cert.org/yaf/index.html) and [SiLK](http://tools.netsa.cert.org/silk/index.html) tools. What is an IPFIX mediator? An IPFIX mediator is an intermediate entity between IPFIX Exporters and Collectors that can potentially provide aggregation, filtering, and modification of IPFIX records. It may provide conversion to or from IPFIX or a conversion of IPFIX transport protocols. super_mediator collects and processes yaf output (IPFIX files or via TCP, UDP, or Spread) and exports that data in IPFIX, JSON, or CSV text format to one or more IPFIX collectors such as [rwflowpack](http://tools.netsa.cert.org/silk/rwflowpack.html), [flowcap](http://tools.netsa.cert.org/silk/flowcap.html), or to text files that may be bulk uploaded to a database. MySQL support is provided for automatic import.

super_mediator can provide simple filtering upon collection or at export time. Any traditional flow field can be used in a filter, including IP address or IPset (requires [SiLK IPset library](http://tools.netsa.cert.org/silk-ipset/index.html)).

super_mediator can be configured to pull the Deep Packet Inspection (DPI) data from yaf and export that information to another IPFIX collector, or simply export the data to a CSV file or JSON file for bulk upload into a database of your choice. Given MySQL credentials, super_mediator will import the files into the given database.

super_mediator can also be configured to perform de-duplication of DNS resource records, DPI data, and SSL/TLS certificate data exported by YAF. It will export the de-duplicated records in IPFIX, CSV, or JSON format. See the man pages and tutorials for more information. 

## Documentation

More information [here](https://tools.netsa.cert.org/super_mediator/docs.html).

## Usage

Create a user network:

```
docker network create --driver bridge isolated_nw
```

Run the super_mediator container and pass in the desired options:

```
docker run --network=isolated_nw --name=super_mediator --rm -i -t certcc/super_mediator -c /usr/local/etc/super_mediator.conf
```

The above command attaches the container to the user defined network and names the container super_mediator.  By default, the included config file [super_mediator.conf](https://tools.netsa.cert.org/super_mediator/super_mediator.conf.html) is based on the following [file](https://bitbucket.ss.dte.cert.org/projects/DOC/repos/super_mediator/browse/super_mediator.conf).  

If you'd like to overwrite the configuration, run the following with your custom configuration file:

```
docker run --network=isolated_nw --name=super_mediator --rm -v $PWD/super_mediator.conf:/usr/local/etc/super_mediator.conf -it certcc/super_mediator
```

Attaching a container to a user defined network allows you to take advantage of automatic service discovery. In other words, if you want containers to be able to resolve IP addresses by container name, you should use user-defined networks.