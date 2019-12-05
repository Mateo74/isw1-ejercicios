class MyToolBarComponent extends React.Component {
  constructor(props) {
    super(props)
  }

	onClickCatalog() {
		this.props.router.navigate("/catalog", {})
	}
	
	onClickCart() {
		this.props.router.navigate("/cart", {})
	}
	
	onClickPurchaseHistory() {
		this.props.router.navigate("/purchaseHistory", {})
	}
	
	onClickLogout() {
		this.props.router.navigate("/", {cartID: -1})
	}

	render() {
		const {title, classes} = this.props

		return (
		<div className={classes.rootToolBar}>
			<AppBar position="static">
				<Toolbar>
					<Typography variant="h6" className={classes.title}>
					{title}
					</Typography>
					<Button
						color="inherit"
						onClick={() => this.onClickCatalog()}>
						Catalog
					</Button>
					<Button
						color="inherit"
						onClick={() => this.onClickCart()}>
						Cart
					</Button>
					<Button
						color="inherit"
						onClick={() => this.onClickPurchaseHistory()}>
						Purchase History
					</Button>
					<Button
						color="inherit"
						onClick={() => this.onClickLogout()}>
						Log Out
					</Button>
				</Toolbar>
			</AppBar>
		</div>
		)
	}

}

// Add style
const MyToolBar = withStyles(styles, {
  withTheme: true
})(MyToolBarComponent)
