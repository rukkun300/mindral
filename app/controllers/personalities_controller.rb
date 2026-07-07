class PersonalitiesController < ApplicationController
   
 TYPES = {
    ["論理型","協力型","変革型"] => { name: "戦略家", industry: "ITコンサルティング、スタートアップ", job: "ITコンサルタント、PM", skill: "課題解決力、チームマネジメント、柔軟性" },
    ["論理型","協力型","安定型"] => { name: "支援家", industry: "金融、公共インフラ、大手メーカー", job: "システムエンジニア、社内SE、総務・労務", skill: "構造化能力、確実性、協調性・サポート力" },
    ["論理型","自走型","変革型"] => { name: "革新者", industry: "先端テック、AI開発、外資系戦略", job: "AIエンジニア、データサイエンティスト、戦略職", skill: "高い専門性、論理的思考、自律的遂行力" },
    ["論理型","自走型","安定型"] => { name: "研究者", industry: "研究開発、品質管理、専門メーカー", job: "研究職、QAエンジニア、財務スペシャリスト", skill: "深い探究心、正確性、自己管理能力" },
    ["直感型","協力型","変革型"] => { name: "企画家", industry: "広告・クリエイティブ、Webマーケ", job: "プランナー、Webマーケター、ディレクター", skill: "発想力、コミュニケーション力、トレンド把握力" },
    ["直感型","協力型","安定型"] => { name: "伴走者", industry: "教育、カスタマーサクセス、福祉", job: "カスタマーサクセス、キャリアアドバイザー、事務", skill: "共感力、傾聴力、丁寧な対応力" },
    ["直感型","自走型","変革型"] => { name: "開拓者", industry: "ゲーム開発、ベンチャー、新規事業", job: "ゲームクリエイター、UI/UXデザイナー、起業家", skill: "圧倒的な創造力、行動力、リスクテイク力" },
    ["直感型","自走型","安定型"] => { name: "芸術家", industry: "伝統工芸、技術職、特定専門職", job: "専任デザイナー、社内技術職、ライター", skill: "独自の世界観、こだわり抜く力、持続力" }
  }

  def index
  end

  def new
    @personality = Personality.new
  end

  def show
    @personality = Personality.find_by(id: params[:id])

    
    answers = [@personality.question1, @personality.question2, @personality.question3]
    axis_env = answers.count("1") >= 2 ? "変革型" : "安定型"

    
    axis_think = session[:axis_think]
    axis_motive = session[:axis_motive]

    
    @result = TYPES[[axis_think, axis_motive, axis_env]]
  end

  def create
    personality = Personality.new(personality_params)
    if personality.save
      flash[:notice] = "診断が完了しました"
      redirect_to personality_path(personality.id)
    else
      redirect_to :action => "new"
    end
  end

  private
    def personality_params
      params.require(:personality).permit(:question1, :question2, :question3)
    end
end