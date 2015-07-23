LikerInfoDropItem = React.createClass({
  render(){
    return (<div>
            
            <a 
              href={`/users/${this.props.liker.id}`}> 
              {this.props.liker.name } </a> likes this
            </div>);
  }
});
