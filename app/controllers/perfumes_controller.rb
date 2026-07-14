class PerfumesController < ApplicationController
    def index
    end

    def new
        @perfume = Perfume.new
    end


    def create 
        perfume = Perfume.new(perfume_parmas)
        if perfume.save
            think_process = [perfume.question1,perfume.question2,perfume.question3]
            session[:axis_think] = think_process.count("1") >= 2 ? "論理型" : "直感型"
            session[:axis_motive] = perfume.question4 == "1" ? "協力型" : "自走型"
            flash[:notice] = "診断が完了しました"
            redirect_to new_personality_path
        else
            redirect_to :action => 'new'
        end
    end

  private
    def perfume_parmas
       params.require(:perfume).permit(:question1, :question2, :question3, :question4, :question5)
    end
end
