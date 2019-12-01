class InputFieldComponent extends React.Component {
  constructor(props) {
    super(props)
  }
	
	render() {
		const {label, value, onChange, classes} = this.props
		return (
			<FormControl fullWidth className={classes.textField} variant="outlined">
				<InputLabel htmlFor="outlined-adornment-amount">{label}</InputLabel>
				<OutlinedInput
					id="outlined-adornment-amount"
					value={value}
					onChange={onChange}
					startAdornment={<InputAdornment position="start">></InputAdornment>}
					labelWidth={60}
					rows="1"
				/>
			</FormControl>
		)
	}
}

const InputField = withStyles(styles, {
  withTheme: true
})(InputFieldComponent)
