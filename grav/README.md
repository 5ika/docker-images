# Quick reference

- **Grav CMS**  https://getgrav.org/
- **GitHub project** https://github.com/5ika/grav-docker
- **Issues** : https://github.com/5ika/grav-docker/issues
- **Maintained by** [Tim Izzo](https://twitter.com/5ika_)

# How to use it

```bash
docker run -d -p 8080:80 5ika/grav
```
Then, you can see the homepage on `http://localhost:8080`.

# Plugins
By default, only the *admin* plugin is installed. You can install more with this command :

```bash
docker exec -it my-container add-plugins plugin-1-name plugin-2-name
```
Example : `docker exec -it my-container add-plugins future widget`
