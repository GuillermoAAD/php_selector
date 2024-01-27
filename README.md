
![php_selector_icon](/resources/php.png)

# PHP SELECTOR

This script allows you to select the PHP version among several installed on your system.

There are two variants available: one for Linux and one for macOS.


## Requirements

- Operating system: Linux or macOS
- PHP versions installed on the system:
  - Linux: php obtained from a PPA repository
  - macOS: php obtained from brew. 


## Use

The best way I have found to use them on each system are the following:

- ### Linux

    Update the **Exec** and **Icon** paths in the [php_selector.desktop](/linux/php_selector.desktop) file.

    Then copy the file to show as shortcut in desktop.

    ```bash
    cp php_selector.desktop ~/.local/share/applications/
    ```

    If necessary, give execution permissions.

- ### macOS

    Generate an alias of the  
    [php_selector.sh](/mac/php_selector.sh) file.

    Move the Alias to the Applications folder.

    ![php_selector_icon](/resources/screenshots/screenshot_1.png)


## Contribute
If you want to contribute to this project, follow these steps:

- Fork the repository.
- Create a branch for your contribution: git checkout -b feature/new-feature.
- Make your changes and commit: git commit -m 'Add new functionality'.
- Push to branch: git push origin feature/new-feature.
- Open a pull request.


## Problems and Suggestions

If you find any problems or have suggestions to improve this script, please create an issue.


## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE)
 file for more details.