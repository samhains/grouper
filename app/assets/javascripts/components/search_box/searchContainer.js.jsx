var SearchContainer = React.createClass({
  render() {
    var cx = React.addons.classSet;
    var classes = cx({
      'hide-results': this.props.hideResults
    });
    return (<div>
              <SearchBox 
                filterText={this.props.filterText} 
                handleInput={this.props.handleInput}/>
              <div className={classes} >

                <SearchResults handleClick={this.props.handleClick} users={this.props.users}/>
              </div>
            </div>);
  }
});
