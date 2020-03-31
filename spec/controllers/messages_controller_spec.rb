require 'rails_helper'


describe MessagesController do

  # 複数のexampleで同一のインスタンスを使いたい場合、letメソッドを利用
  # letメソッドは初回の呼び出し時のみ実行する特徴がある。つまりこの一回だけしか実行しない
  let(:group) { create(:group) } #
  let(:user) { create(:user) }

  #****************** MessagesController - index **********************
  #indexアクションのテスト

  # ------テスト内容------
  # ログインしている場合 (context)
  #   アクション内で定義しているインスタンス変数があるか
  #   該当するビューが描画されているか
  #   ログインしていない場合
  #   意図したビューにリダイレクトできているか

  describe '#index' do
    # ログインしている場合のテストを記述
    context 'log in' do
      before do
        login user
        get :index, params: { group_id: group.id }
      end

      # アクション内で定義しているインスタンス変数が一致するかどうか
      it 'assigns @message' do
        # be_a_newマッチャ 対象が引数で指定したクラスのインスタンスかつ
        # 未保存のレコードであるかどうか確かめることができる
        expect(assigns(:message)).to be_a_new(Message)
      end

      # アクション内で定義しているインスタンス変数が一致するかどうか
      it 'assigns @group' do
        expect(assigns(:group)).to eq group
      end

      # indexアクションに対してindexビューが描画されているか
      it 'renders index' do
        expect(response).to render_template :index
      end
    end

    # ログインしていない場合のテスト
    context 'not log in' do
      before do
        get :index, params: { group_id: group.id }
      end

      # 意図したビューにリダイレクトできているか
      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  #****************** MessagesController - create **********************
  #createアクションのテスト（メッセージの作成機能）

  # ------テスト内容------
  # ログインしているかつ、保存に成功した場合
  #   メッセージの保存はできたのか
  #   意図した画面に遷移しているか
  # ログインしているが、保存に失敗した場合
  #   メッセージの保存は行われなかったか
  #   意図したビューが描画されているか
  # ログインしていない場合
  #   意図した画面にリダイレクトできているか

  describe '#create' do
  # attributes_for(:message) FactoryBotによって定義されるメソッド
  # オブジェクトを生成せずにハッシュを生成する
  let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    # ログインしている
    context 'log in' do
      before do
        login user
      end

      # かつ保存に成功した場合
      context 'can save' do
        subject {
          post :create,
          params: params
        }

        # メッセージの保存はできたのか
        it 'count up message' do
          # change().by() Messageモデルのレコードの総数が1個増えたかどうか
          expect{ subject }.to change(Message, :count).by(1)
        end
        # 意図した画面に遷移しているか
        it 'redirects to group_messages_path' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      # 保存に失敗した場合
      context 'can not save' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }
        # メッセージの保存は行われなかったか
        it 'does not count up' do
          # not_to 〜でないかどうかを確認できる
          # Messageモデルのレコード数がchangeしないこと => 保存に失敗したことを意味する
          expect{ subject }.not_to change(Message, :count)
        end
        # 意図したビューが描画されているか
        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    # ログインしていない場合
    context 'not log in' do
      # 意図した画面にリダイレクトできているか
      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end