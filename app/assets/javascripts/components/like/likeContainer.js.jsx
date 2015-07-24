var LikeContainer = React.createClass({
  getInitialState(){
    return {
      liked: this.props.liked,
      likers: this.props.likers,
      showLikers: false
    };
  },
  toggleLikers(){
    var showLikers = this.state.showLikers;
    this.setState({ showLikers: !showLikers });
  },
  clickHandler(){
    var liked = this.state.liked;
    if(!this.state.liked){
      $.ajax({
        method: "POST",
        url: this.props.url,
        data: { id: this.props.id },
        success: function(){
          this.setState({liked: !liked});
        }.bind(this)
      });
    }
    else{
      $.ajax({
        method: "DELETE",
        url: this.props.url,
        data: { id: this.props.id },
        success: function(){
          this.setState({liked: !liked});
        }.bind(this)
      });
    }
    $.get(this.props.url, function(likerData) {
      this.setState({ likers: likerData.likers});
    }.bind(this));
  },
  render(){

    return (<div className='like-container'>
              <LikeButton 
                clickHandler={this.clickHandler}
                liked={this.state.liked}
                />
               <LikerInfoContainer 
                 toggleLikers={this.toggleLikers} 
                 showLikers={this.state.showLikers} 
                 likers={this.state.likers}/>
            </div>);
  }

});
