var LikeContainer = React.createClass({
  getInitialState(){
    return {
      liked: this.props.liked,
      likers: this.props.likers
    };
  },
  toggleLikers(){
  },
  clickHandler(){
    var liked = this.state.liked;
    if(!this.state.liked){
      $.ajax({
        method: "POST",
        url: this.props.url,
        data: { id: this.props.id },
        success: function(x){
          console.log('yes', x);
        }
      });
    }
    else{
      $.ajax({
        method: "DELETE",
        url: this.props.url,
        data: { id: this.props.id },
        success: function(x){
          console.log('no', x);
        }
      });
    }
    $.get(this.props.url, function(likerData) {
      this.setState({likers: likerData.likers});
    }.bind(this));
    this.setState({liked: !liked});
  },

  render(){
    var likerInfo;

    return (<div >
              <LikeButton 
                clickHandler={this.clickHandler}
                liked={this.state.liked}
                />
               <LikerInfoContainer likers={this.state.likers}/>
            </div>);
  }

});
