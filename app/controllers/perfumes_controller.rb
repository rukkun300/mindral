class PerfumesController < ApplicationController
    def index
    end

    def new
        @perfume = Perfume.new
    end

    def show 
        @perfume = Perfume.find_by(id:params[:id])
        #思考プロセス（論理型か直感型か）を判断するプログラム
        think_process = [@perfume.question1, @perfume.question2, @perfume.question3]
        session[:axis_think] = think_process.count("1") >= 2 ? "論理型" : "直感型"
        
        #協力型か自走型をQ４の回答に基づいて判断している。
        session[:axis_motive] = @perfume.question4 == "1" ? "協力型" : "自走型"
    end

    def create 
        perfume = Perfume.new(perfume_parmas)
        if perfume.save
            flash[:notice] = "診断が完了しました"
            redirect_to perfume_path(perfume.id)
        else
            redirect_to :action => 'new'
        end
    end

  private
    def perfume_parmas
       params.require(:perfume).permit(:question1, :question2, :question3, :question4, :question5)
    end
end
