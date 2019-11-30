class CatalogComponent extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    const {
      router,
      cartID,
      classes,
    } = this.props

		let catalog = {
			validBook1: 20,
			validBook2: 40
		}
		
		let catalogAsArray = []
		Object.keys(catalog).forEach((key) => catalogAsArray.push({name: key, price: catalog.key}))

    return (
      <div>
        <Typography component="h1" gutterBottom>
          Book Catalog:
				</Typography>
        <List component="nav" className={classes.rootList} aria-label="substrings">
          {
            catalogAsArray.map((item, ix) => {
              return (
                <ListItem key={ix}>
                  <ListItemText primary={item.name} />
                </ListItem>
              )
            })
          }
        </List>
      </div>
    )
  }
}

// Add style
const CatalogView = withStyles(styles, {
  withTheme: true
})(CatalogComponent)
