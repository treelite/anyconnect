# anyconnnect

基于 Ubuntu 14.04，使用 [ocserv 0.10.10](http://www.infradead.org/ocserv/) 构建的 anyconnect server docker 镜像

## Usage

### 准备安全证书

启动服务器需要使用 CA 证书、服务器证书与服务器密钥，分别按以下方式命名：

* `ca-cert.pem` CA 证书
* `server-cert.pem` 服务器证书
* `server-key.pem` 服务器密钥

并将这些文件放在一个单独的目录下，比如说 `$HOME/certs`

另外服务器默认配置为只允许以证书验证方式登陆，所以还需要额外为客户端准备证书

如果未创建过这些东东，可以参考[这篇文章](http://bitinn.net/11084/)中的“配置OCserv”部分生成相关文件

### 获取镜像

```sh
docker pull treelite/anyconnect
```

或者手动构建：

```sh
git clone https://github.com/treelite/anyconnect.git
cd anyconnect
docker build -t my-anyconnect .
```

### 启动镜像

```sh
docker run -d --privileged -p 7000:443 --name anyconnect -v $HOME/certs:/certs treelite/anyconnect
```

* `-p 7000:443` 指定宿主端口 `7000` 与容器的 `443` 端口绑定以提供服务
* `-v $HOME/certs:/certs` 将宿主的 `$HOME/certs` 目录映射到容器的 `/certs` 目录以提供服务器需要的证书

由于容器需要进行路由表设置，因此需要添加 `--privileged` 参数授权操作
