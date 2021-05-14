# Kubernetes Examples UI

## How are example pages created
In immediate children of the `Examples/` folder there is a `.md` file which imports a list of all elements in the folder generator called `deepChildrenList`.
Each `.md` file is named after the folder and has same title in its frontMatter (ex. StorageClass.md located in StorageClass folder)
`deepChildrenList` looks for all the folders and files inside same folder and sections each content by child folder, It turns `yaml` into code and `.md` files without `title` or Frontmatter variable into parsed markdown.

### How to create new pages
To create pages  that appear at the top navigation, always use the `nav_order` parameter in your pages’ YAML front matter.
Using `nav-order` you can also decide the order of appearance in the menu.
_For more information check the base theme mentioned below._

If a new folder, child of `Examples/` has been created on the master branch and pulled into this branch, to create a new page for the resource follow the steps:
- copy the .md file from any of the previous folders located at its root (ex. StorageClass.md located in StorageClass folder),
- rename and replace the title inside the file with the current folder name


## Credits To
- [Jekyll](https://jekyllrb.com/)
- [prismJS](https://prismjs.com/)
- [Just-the-docs jekyll documentation theme](https://github.com/pmarsceill/just-the-docs)

